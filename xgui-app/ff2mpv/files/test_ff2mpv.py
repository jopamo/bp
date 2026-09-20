import importlib.util
import io
import json
import os
from pathlib import Path
import struct
import subprocess
import sys
import tempfile
import time
from types import SimpleNamespace
import unittest
from unittest.mock import patch


HOST = Path(os.environ.get("FF2MPV_HOST", Path(__file__).with_name("ff2mpv.py")))
spec = importlib.util.spec_from_file_location("ff2mpv", HOST)
ff2mpv = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ff2mpv)


def frame(message):
    payload = json.dumps(message, ensure_ascii=False).encode("utf-8")
    return struct.pack("@I", len(payload)) + payload


class NativeHostTests(unittest.TestCase):
    def invoke(self, data, launch_error=None):
        output = io.BytesIO()
        errors = io.StringIO()
        with (
            patch.object(ff2mpv.sys, "stdin", SimpleNamespace(buffer=io.BytesIO(data))),
            patch.object(ff2mpv.sys, "stdout", SimpleNamespace(buffer=output)),
            patch.object(ff2mpv.sys, "stderr", errors),
            patch.object(ff2mpv.subprocess, "Popen", side_effect=launch_error) as launch,
        ):
            result = ff2mpv.main()
        return result, output.getvalue(), errors.getvalue(), launch

    def test_launch_and_reply(self):
        url = "https://example.org/動画?q=a b;$(false)"
        options = ["--fullscreen", "--title=My video"]
        result, output, errors, launch = self.invoke(frame({"url": url, "options": options}))
        self.assertEqual((result, output, errors), (0, frame("ok"), ""))
        launch.assert_called_once_with(
            ["/usr/bin/mpv", "--no-terminal", *options, "--", url],
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )

    def test_options_are_optional(self):
        for message in ({"url": "file:///video"}, {"url": "file:///video", "options": None}):
            with self.subTest(message=message):
                result, output, errors, launch = self.invoke(frame(message))
                self.assertEqual((result, output, errors), (0, frame("ok"), ""))
                self.assertEqual(
                    launch.call_args.args[0],
                    ["/usr/bin/mpv", "--no-terminal", "--", "file:///video"],
                )

    def test_url_cannot_become_an_option(self):
        _, _, _, launch = self.invoke(frame({"url": "--script=unexpected.lua"}))
        self.assertEqual(launch.call_args.args[0][-2:], ["--", "--script=unexpected.lua"])

    def test_empty_input_is_quiet(self):
        result, output, errors, launch = self.invoke(b"")
        self.assertEqual((result, output, errors), (0, b"", ""))
        launch.assert_not_called()

    def test_invalid_frames_never_launch(self):
        for data in (
            b"\x01",
            struct.pack("@I", 0),
            struct.pack("@I", ff2mpv.MAX_MESSAGE_SIZE + 1),
            struct.pack("@I", 20) + b"{}",
            struct.pack("@I", 1) + b"\xff",
            struct.pack("@I", 1) + b"{",
        ):
            with self.subTest(data=data):
                result, output, errors, launch = self.invoke(data)
                self.assertEqual((result, output), (1, b""))
                self.assertTrue(errors.startswith("ff2mpv:"))
                launch.assert_not_called()

    def test_invalid_messages_never_launch(self):
        for message in (
            None, [], "url", {}, {"url": ""}, {"url": 1}, {"url": "bad\0url"},
            {"url": "https://example.org", "options": "--fullscreen"},
            {"url": "https://example.org", "options": {}},
            {"url": "https://example.org", "options": False},
            {"url": "https://example.org", "options": [1]},
            {"url": "https://example.org", "options": ["bad\0option"]},
        ):
            with self.subTest(message=message):
                result, output, errors, launch = self.invoke(frame(message))
                self.assertEqual((result, output), (1, b""))
                self.assertTrue(errors.startswith("ff2mpv:"))
                launch.assert_not_called()

    def test_launch_failure_is_not_acknowledged(self):
        result, output, errors, launch = self.invoke(
            frame({"url": "https://example.org"}), FileNotFoundError("mpv is missing")
        )
        self.assertEqual((result, output), (1, b""))
        self.assertIn("mpv is missing", errors)
        launch.assert_called_once()

    def test_only_one_request_is_processed(self):
        result, output, errors, launch = self.invoke(
            frame({"url": "https://example.org/first"})
            + frame({"url": "https://example.org/second"})
        )
        self.assertEqual((result, output, errors), (0, frame("ok"), ""))
        launch.assert_called_once()
        self.assertEqual(launch.call_args.args[0][-1], "https://example.org/first")

    def test_detached_child_does_not_retain_browser_pipes(self):
        with tempfile.TemporaryDirectory() as directory:
            directory = Path(directory)
            child = directory / "mpv"
            state = directory / "state.json"
            release = directory / "release"
            child.write_text(
                f"#!{sys.executable}\n"
                "import json, os, pathlib, sys, time\n"
                "print('not a native message', flush=True)\n"
                "print('child stderr', file=sys.stderr, flush=True)\n"
                f"state = pathlib.Path({str(state)!r})\n"
                "temporary = state.with_suffix('.tmp')\n"
                "temporary.write_text(json.dumps([os.getpid(), os.getsid(0), "
                "os.getpgrp(), sys.stdin.buffer.read() == b'']))\n"
                "temporary.replace(state)\n"
                "deadline = time.monotonic() + 15\n"
                f"while not pathlib.Path({str(release)!r}).exists() and time.monotonic() < deadline:\n"
                "    time.sleep(0.01)\n"
            )
            child.chmod(0o755)
            # Substitute only the executable; exercise the real process launch.
            driver = (
                "import runpy, sys; namespace = runpy.run_path(sys.argv[1]); "
                "namespace['main'].__globals__['MPV'] = sys.argv[2]; "
                "sys.exit(namespace['main']())"
            )
            process = subprocess.Popen(
                [sys.executable, "-c", driver, str(HOST), str(child)],
                stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                start_new_session=True,
            )
            try:
                output, errors = process.communicate(frame({"url": "https://example.org"}), timeout=5)
                self.assertEqual((process.returncode, output, errors), (0, frame("ok"), b""))
                deadline = time.monotonic() + 5
                while not state.exists() and time.monotonic() < deadline:
                    time.sleep(0.01)
                self.assertTrue(state.exists(), "child did not start")
                pid, session, group, stdin_eof = json.loads(state.read_text())
                self.assertEqual((session, group), (pid, pid))
                self.assertNotEqual(session, process.pid)
                self.assertTrue(stdin_eof)
            finally:
                release.touch()
                if process.poll() is None:
                    process.kill()
                process.communicate(timeout=5)

    def test_manifest_matches_installed_host(self):
        manifest = json.loads(Path(__file__).with_name("ff2mpv.json").read_text())
        self.assertEqual(manifest["name"], "ff2mpv")
        self.assertEqual(manifest["type"], "stdio")
        self.assertEqual(manifest["path"], "/usr/bin/ff2mpv.py")
        self.assertEqual(manifest["allowed_extensions"], ["ff2mpv@yossarian.net"])


if __name__ == "__main__":
    unittest.main()
