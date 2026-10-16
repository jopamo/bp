"""Check certificate publication without accessing live server configuration."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).resolve().parent / "bin/lighttpd_certs"
BASH = shutil.which("bash")
OPENSSL = shutil.which("openssl")


class LighttpdCertificatesTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="lighttpd certificates ")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.live = self.root / "letsencrypt/live/example.org"
        self.live.mkdir(parents=True)
        config = self.root / "lighttpd"
        config.mkdir()
        (config / "lighttpd_cert_domains.conf").write_text("example.org\n")
        self.script = self.root / "lighttpd_certs"
        self.script.write_text(
            SCRIPT.read_text()
            .replace("/etc/lighttpd", str(config))
            .replace("/etc/letsencrypt", str(self.root / "letsencrypt"))
            .replace("/var/lighttpd", str(self.root / "webroot"))
        )
        self.tools = self.root / "tools"
        self.tools.mkdir()
        self.stub("certbot", 'exit "${CERTBOT_STATUS:-0}"')
        self.env = dict(os.environ, PATH=f"{self.tools}:{os.environ['PATH']}")
        subprocess.run([
            OPENSSL, "req", "-x509", "-newkey", "rsa:2048", "-nodes",
            "-subj", "/CN=example.org", "-days", "1",
            "-keyout", str(self.live / "privkey.pem"),
            "-out", str(self.live / "cert.pem"),
        ], check=True, capture_output=True)
        self.output = self.live / "web.pem"
        self.output.write_bytes(b"previous certificate and key\n")
        self.output.chmod(0o600)

    def stub(self, name, body):
        path = self.tools / name
        path.write_text(f"#!{BASH}\n{body}\n")
        path.chmod(0o755)

    def run_script(self):
        return subprocess.run(
            [BASH, str(self.script)], env=self.env,
            capture_output=True, text=True,
        )

    def test_publish_valid_pair_with_private_permissions(self):
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            self.output.read_bytes(),
            (self.live / "cert.pem").read_bytes()
            + (self.live / "privkey.pem").read_bytes(),
        )
        self.assertEqual(self.output.stat().st_mode & 0o777, 0o600)
        self.assertEqual(list(self.live.glob(".web.pem.*")), [])

    def test_failures_preserve_previous_output(self):
        key = (self.live / "privkey.pem").read_bytes()
        other = subprocess.run(
            [OPENSSL, "genpkey", "-algorithm", "RSA", "-pkeyopt", "rsa_keygen_bits:2048"],
            check=True, capture_output=True,
        ).stdout
        for failure in (
            "certbot", "missing-key", "invalid-key", "mismatched-key", "write", "rename",
        ):
            with self.subTest(failure=failure):
                if failure == "certbot":
                    self.env["CERTBOT_STATUS"] = "7"
                elif failure == "missing-key":
                    (self.live / "privkey.pem").unlink()
                elif failure == "invalid-key":
                    (self.live / "privkey.pem").write_bytes(b"invalid key\n")
                elif failure == "mismatched-key":
                    (self.live / "privkey.pem").write_bytes(other)
                elif failure == "write":
                    self.stub("cat", 'printf "partial output\\n"; exit 8')
                elif failure == "rename":
                    self.stub("mv", "exit 9")
                result = self.run_script()
                self.assertNotEqual(result.returncode, 0, result.stderr)
                self.assertEqual(
                    self.output.read_bytes(), b"previous certificate and key\n",
                )
                self.assertEqual(list(self.live.glob(".web.pem.*")), [])
                self.env.pop("CERTBOT_STATUS", None)
                (self.live / "privkey.pem").write_bytes(key)
                for name in ("cat", "mv"):
                    (self.tools / name).unlink(missing_ok=True)


if __name__ == "__main__":
    unittest.main()
