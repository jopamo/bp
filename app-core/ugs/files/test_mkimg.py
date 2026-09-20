"""Exercise image exclusions without reading or archiving the live filesystem."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parent / "bin" / "mkimg"
BASH = shutil.which("bash")


class MkimgTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.calls = self.root / "calls"
        self.env = dict(os.environ, PATH=str(self.bin), CALLS=str(self.calls))
        for tool in ("grep", "realpath", "basename"):
            (self.bin / tool).symlink_to(shutil.which(tool))
        self.stub("whoami", "echo root")
        self.stub("portageq", 'echo LEGACY >> "$CALLS"; exit 99')
        self.stub("tar", 'printf "%s\\n" "$@" >> "$CALLS"')
        for tool in ("1g4-rootfs-policy", "1g4-system-setup"):
            self.stub(tool, ":")
        self.stub("corepkgq", '''
case "$*" in
  "get_repos /")
    [ "${FAIL_QUERY:-}" != repos ] || exit 7
    echo 'bp private-overlay' ;;
  "get_repo_path / bp")
    [ "${FAIL_QUERY:-}" != path ] || exit 7
    printf '%s\\n' "${REPO_PATH-/var/db/repos/bp}" ;;
  "get_repo_path / private-overlay")
    echo '/srv/private overlay' ;;
  distdir)
    [ "${FAIL_QUERY:-}" != distdir ] || exit 7
    printf '%s\\n' "${DISTDIR_PATH-/var/cache/distfiles}" ;;
  *) exit 9 ;;
esac
''')

    def stub(self, name, body):
        path = self.bin / name
        path.write_text(f"#!{BASH}\n{body}\n")
        path.chmod(0o755)

    def run_image(self, *args):
        return subprocess.run(
            [BASH, str(SCRIPT), "-q", *args, str(self.root / "archive")],
            env=self.env, capture_output=True, text=True,
        )

    def test_live_root_uses_configured_repos_and_distdir_without_portage(self):
        (self.bin / "portageq").unlink()
        result = self.run_image("-s")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.calls.read_text().splitlines()
        for path in ("/var/db/repos/bp", "/srv/private overlay", "/var/cache/distfiles"):
            self.assertIn(f"--exclude={path}/*", args)
        self.assertNotIn("--exclude=/*", args)

    def test_invalid_query_path_never_runs_tar(self):
        for variable in ("REPO_PATH", "DISTDIR_PATH"):
            for value in ("", "/", "////", "/tmp/..", "relative", "/one\n/two"):
                with self.subTest(variable=variable, value=value):
                    self.env[variable] = value
                    result = self.run_image("-s")
                    self.assertNotEqual(result.returncode, 0)
                    self.assertFalse(self.calls.exists())
                    del self.env[variable]

    def test_failed_query_never_runs_tar(self):
        for query in ("repos", "path", "distdir"):
            with self.subTest(query=query):
                self.env["FAIL_QUERY"] = query
                result = self.run_image("-s")
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse(self.calls.exists())

    def test_absent_corepkgq_does_not_fall_back_to_portageq(self):
        (self.bin / "corepkgq").unlink()
        result = self.run_image("-s")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.calls.read_text().splitlines()
        self.assertNotIn("LEGACY", args)
        self.assertIn("--exclude=/var/db/repos/bp/*", args)

    def test_alternate_root_does_not_query_host(self):
        self.stub("corepkgq", 'echo QUERY >> "$CALLS"; exit 99')
        target = self.root / "target"
        target.mkdir()
        result = self.run_image("-t", str(target))
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.calls.read_text().splitlines()
        self.assertNotIn("QUERY", args)
        self.assertNotIn("LEGACY", args)
        self.assertIn(f"--exclude={target}/var/db/repos/bp/*", args)


if __name__ == "__main__":
    unittest.main()
