"""Check trust selection and certificate updates in a disposable root."""

import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


FILES = Path(__file__).resolve().parent
SOURCE = Path(sys.argv.pop(1)).resolve()
EBUILD = next(FILES.parent.glob("*.ebuild"))


def certdata_object(label, value, *, cutoff=None, trusted=True):
    octal = lambda data: "".join(f"\\{byte:03o}" for byte in data)
    certificate = (
        "CKA_CLASS CK_OBJECT_CLASS CKO_CERTIFICATE\n"
        f'CKA_LABEL UTF8 "{label}"\n'
        f"CKA_VALUE MULTILINE_OCTAL\n{octal(value)}\nEND\n"
    )
    if cutoff is not None:
        certificate += (
            "CKA_NSS_SERVER_DISTRUST_AFTER MULTILINE_OCTAL\n"
            f"{octal(cutoff)}\nEND\n"
        )
    trust = "CKT_NSS_TRUSTED_DELEGATOR" if trusted else "CKT_NSS_NOT_TRUSTED"
    return (
        certificate + "\nCKA_CLASS CK_OBJECT_CLASS CKO_NSS_TRUST\n"
        f'CKA_LABEL UTF8 "{label}"\n'
        f"CKA_TRUST_SERVER_AUTH CK_TRUST {trust}\n\n"
    )


class CertificatesTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="ca certificates ")
        self.addCleanup(self.temporary.cleanup)
        self.work = Path(self.temporary.name)

    def run_converter(self):
        result = subprocess.run(
            [sys.executable, str(FILES / "certdata2pem.py")],
            cwd=self.work, capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        return {path.name: path.read_bytes() for path in self.work.glob("*.crt")}

    def test_constraints_collisions_and_repeat_conversion(self):
        data = "BEGINDATA\n"
        data += certdata_object("Collision Root", b"one")
        data += certdata_object("Collision_Root", b"two")
        data += certdata_object("Duplicate", b"one")
        data += certdata_object("Plain", b"three")
        data += certdata_object("Denied", b"four", trusted=False)
        data += certdata_object("Past", b"five", cutoff=b"241130235959Z")
        data += certdata_object("Future", b"six", cutoff=b"491130235959Z")
        (self.work / "certdata.txt").write_text(data)
        first = self.run_converter()
        self.assertEqual(set(first), {
            "Collision_Root.crt", "Plain.crt",
            hashlib.sha256(b"two").hexdigest() + ".crt",
        })
        self.assertEqual(self.run_converter(), first)

    def prepare_root(self):
        self.root = self.work / "root"
        self.certs = self.root / "etc/ssl/certs"
        self.certs.mkdir(parents=True)
        self.share = self.root / "usr/share/ca-certificates"
        self.share.mkdir(parents=True)
        certificate = next((SOURCE / "mozilla").glob("*.crt")).read_bytes()
        (self.share / "managed.crt").write_bytes(certificate)
        (self.certs / "admin.pem").write_bytes(certificate)
        self.conf = self.root / "etc/ca-certificates.conf"
        self.conf.write_text("managed.crt\n")
        binary = self.root / "usr/bin"
        binary.mkdir(parents=True)
        shutil.copy2(SOURCE / "sbin/update-ca-certificates", binary)

    def postinst(self, env=None):
        return subprocess.run(
            ["bash", "-c", """
                inherit() { :; }
                die() { echo "$*" >&2; exit 1; }
                source "$1"
                EROOT="$2/"
                pkg_postinst
            """, "test-postinst", str(EBUILD), str(self.root)],
            env=env, capture_output=True, text=True,
        )

    def test_alternate_root_update_and_relocation(self):
        self.prepare_root()
        local = self.root / "usr/local/share/ca-certificates"
        local.mkdir(parents=True)
        shutil.copy2(self.share / "managed.crt", local / "local.crt")
        admin = (self.certs / "admin.pem").read_bytes()
        result = self.postinst()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual((self.certs / "admin.pem").read_bytes(), admin)
        bundle = self.certs / "ca-certificates.crt"
        self.assertEqual(bundle.read_bytes().count(b"BEGIN CERTIFICATE"), 2)

        moved = self.work / "moved"
        self.root.rename(moved)
        self.root = moved
        self.certs = moved / "etc/ssl/certs"
        for name in ("managed.pem", "local.pem"):
            link = self.certs / name
            self.assertFalse(os.readlink(link).startswith("/"))
            self.assertEqual(link.read_bytes(), admin)

        (moved / "etc/ca-certificates.conf").write_text("!managed.crt\n")
        result = self.postinst()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertFalse((self.certs / "managed.pem").exists())
        self.assertEqual((self.certs / "admin.pem").read_bytes(), admin)
        self.assertEqual(
            (self.certs / "ca-certificates.crt").read_bytes()
            .count(b"BEGIN CERTIFICATE"), 1,
        )
        (moved / "usr/local/share/ca-certificates/local.crt").unlink()
        result = self.postinst()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual((self.certs / "ca-certificates.crt").read_bytes(), b"")
        self.assertEqual((self.certs / "admin.pem").read_bytes(), admin)

    def test_rehash_failure_preserves_bundle(self):
        self.prepare_root()
        bundle = self.certs / "ca-certificates.crt"
        bundle.write_bytes(b"previous bundle\n")
        tools = self.work / "tools"
        tools.mkdir()
        openssl = tools / "openssl"
        openssl.write_text("#!/bin/sh\nexit 29\n")
        openssl.chmod(0o755)
        env = dict(os.environ, PATH=f"{tools}:{os.environ['PATH']}")
        result = self.postinst(env)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(bundle.read_bytes(), b"previous bundle\n")
        self.assertTrue((self.certs / "admin.pem").is_file())
        self.assertEqual(list(self.certs.glob("ca-certificates.crt.*")), [])

    def test_install_expiry_parsing(self):
        source = self.work / "source"
        (source / "mozilla").mkdir(parents=True)
        image = self.work / "image"
        (image / "etc").mkdir(parents=True)
        (image / "usr/share/ca-certificates").mkdir(parents=True)
        certificate = source / "mozilla/probe.crt"
        installed = self.work / "installed"
        for date, status, keep in (
            ("notAfter=Oct  6 08:39:56 2046 GMT", 0, True),
            ("notAfter=Oct  6 08:39:56 2000 GMT", 0, False),
            ("notAfter=invalid", 1, False),
        ):
            with self.subTest(date=date):
                certificate.write_text(date + "\n")
                installed.unlink(missing_ok=True)
                result = subprocess.run([
                    "bash", "-c", """
                        inherit() { :; }
                        die() { echo "$*" >&2; exit 1; }
                        einfo() { :; }
                        keepdir() { :; }
                        dobin() { :; }
                        doman() { :; }
                        dosym() { :; }
                        insinto() { :; }
                        dodir() { :; }
                        doins() { echo "$1" >> "$INSTALLED"; }
                        openssl() { cat "$3"; }
                        source "$1"
                        S=$2 ED=$3 EPYTHON=$4 INSTALLED=$5
                        src_install
                    """, "test-install", str(EBUILD), str(source),
                    str(image), sys.executable, str(installed),
                ], capture_output=True, text=True)
                self.assertEqual(result.returncode, status, result.stderr)
                self.assertEqual(installed.exists(), keep)


if __name__ == "__main__":
    unittest.main()
