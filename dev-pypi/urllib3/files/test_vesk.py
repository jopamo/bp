"""Downstream Vesk identity and TLS regressions (stdlib + openssl CLI only)."""

import contextlib
from pathlib import Path
import socket
import ssl
import subprocess
import sys
import tempfile
import threading
import unittest
import warnings

with warnings.catch_warnings():
    warnings.simplefilter("error")
    import urllib3
from urllib3.util import ssl_ as urllib3_ssl


class IdentityTests(unittest.TestCase):
    def test_native_identity(self):
        import _ssl

        self.assertGreaterEqual(ssl.VESK_VERSION_NUMBER, 0x04030100)
        self.assertEqual(ssl.VESK_VERSION_NUMBER, _ssl.VESK_VERSION_NUMBER)
        self.assertEqual(ssl.VESK_VERSION, _ssl.VESK_VERSION)
        self.assertTrue(ssl.VESK_VERSION.startswith("vesk "))
        self.assertFalse(urllib3_ssl.HAS_NEVER_CHECK_COMMON_NAME)

    def test_backend_selection(self):
        # Each import must run afresh, including urllib3's backend gate.
        cases = [
            ("OpenSSL 1.1.1", (1, 1, 1), None, None),
            ("OpenSSL 1.0.2", (1, 0, 2), None, "ImportError"),
            ("LibreSSL 4.2.9", (2, 0, 0), None, "NotOpenSSLWarning"),
            ("vesk 4.3.1", (2, 0, 0), None, "NotOpenSSLWarning"),
            ("LibreSSL 4.2.9", (2, 0, 0), 0x04030000, "ImportError"),
            ("LibreSSL 4.2.9", (2, 0, 0), 0x04030100, None),
        ]
        for banner, version, vesk, error in cases:
            with self.subTest(banner=banner, vesk=vesk):
                code = f"""
import ssl, warnings
for name in ("VESK_VERSION", "VESK_VERSION_NUMBER"):
    if hasattr(ssl, name):
        delattr(ssl, name)
ssl.OPENSSL_VERSION = {banner!r}
ssl.OPENSSL_VERSION_INFO = {version!r}
vesk = {vesk!r}
expected_error = {error!r}
if vesk is not None:
    ssl.VESK_VERSION_NUMBER = vesk
warnings.simplefilter("error")
try:
    import urllib3
except Exception as exc:
    assert type(exc).__name__ == expected_error, repr(exc)
else:
    assert expected_error is None, "unsupported backend accepted"
"""
                subprocess.run([sys.executable, "-c", code], check=True)


class TLSTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.temp.cleanup)
        cls.path = Path(cls.temp.name)
        (cls.path / "req.cnf").write_text(
            "[req]\ndistinguished_name=dn\n[dn]\n"
        )

        def openssl(*args):
            result = subprocess.run(
                ["openssl", *args], cwd=cls.path,
                stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            )
            if result.returncode:
                raise RuntimeError(result.stderr.decode())

        openssl(
            "req", "-config", "req.cnf", "-x509", "-newkey", "rsa:2048", "-nodes",
            "-keyout", "ca.key", "-out", "ca.pem", "-days", "2",
            "-subj", "/CN=Vesk test CA",
            "-addext", "basicConstraints=critical,CA:TRUE",
            "-addext", "keyUsage=critical,keyCertSign,cRLSign",
        )
        openssl(
            "req", "-config", "req.cnf", "-new", "-newkey", "rsa:2048", "-nodes",
            "-keyout", "server.key", "-out", "server.csr",
            "-subj", "/CN=localhost",
        )
        extensions = (
            "basicConstraints=critical,CA:FALSE\n"
            "keyUsage=critical,digitalSignature,keyEncipherment\n"
            "extendedKeyUsage=serverAuth\n"
            "subjectKeyIdentifier=hash\n"
            "authorityKeyIdentifier=keyid,issuer\n"
        )
        for serial, (name, san) in enumerate([
            ("valid", "DNS:localhost,IP:127.0.0.1"),
            ("wrong", "DNS:other.invalid"),
            ("cn", None),
        ], start=2):
            (cls.path / "ext.cnf").write_text(
                extensions + (f"subjectAltName={san}\n" if san else "")
            )
            openssl(
                "x509", "-req", "-in", "server.csr", "-CA", "ca.pem",
                "-CAkey", "ca.key", "-set_serial", str(serial), "-days", "2",
                "-extfile", "ext.cnf", "-out", f"{name}.pem",
            )
        (cls.path / "index").touch()
        (cls.path / "serial").write_text("10\n")
        (cls.path / "ca.cnf").write_text(
            "[ca]\ndefault_ca=issuer\n[issuer]\n"
            "database=index\nserial=serial\nnew_certs_dir=.\n"
            "certificate=ca.pem\nprivate_key=ca.key\n"
            "default_md=sha256\npolicy=policy\n"
            "[policy]\ncommonName=supplied\n"
            "[leaf]\n" + extensions + "subjectAltName=DNS:localhost\n"
        )
        openssl(
            "ca", "-batch", "-config", "ca.cnf", "-in", "server.csr",
            "-out", "expired.pem", "-extensions", "leaf",
            "-startdate", "20000101000000Z", "-enddate", "20010101000000Z",
        )

    @contextlib.contextmanager
    def server(self, certificate="valid", version=ssl.TLSVersion.TLSv1_3):
        context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        context.minimum_version = context.maximum_version = version
        context.load_cert_chain(
            self.path / f"{certificate}.pem", self.path / "server.key"
        )
        context.set_alpn_protocols(["http/1.1"])
        errors = []
        with socket.socket() as listener:
            listener.bind(("127.0.0.1", 0))
            listener.listen()
            listener.settimeout(5)

            def serve():
                try:
                    conn, _ = listener.accept()
                    with conn:
                        conn.settimeout(5)
                        with context.wrap_socket(conn, server_side=True) as tls:
                            if tls.recv(4096):
                                tls.sendall(
                                    b"HTTP/1.1 200 OK\r\nContent-Length: 2\r\n"
                                    b"Connection: close\r\n\r\nok"
                                )
                except (ssl.SSLError, ConnectionError):
                    # Clients deliberately abort rejected handshakes.
                    pass
                except Exception as exc:
                    errors.append(exc)

            thread = threading.Thread(target=serve, daemon=True)
            thread.start()
            try:
                yield listener.getsockname()[1]
            finally:
                thread.join(6)
                self.assertFalse(thread.is_alive(), "TLS server hung")
                self.assertEqual(errors, [])

    def test_defaults(self):
        for context in (ssl.create_default_context(), urllib3_ssl.create_urllib3_context()):
            self.assertEqual(context.verify_mode, ssl.CERT_REQUIRED)
            self.assertTrue(context.check_hostname)
            self.assertGreaterEqual(context.minimum_version, ssl.TLSVersion.TLSv1_2)
            if ssl.OP_NO_COMPRESSION:
                self.assertTrue(context.options & ssl.OP_NO_COMPRESSION)
            if sys.version_info >= (3, 13):
                self.assertTrue(context.verify_flags & ssl.VERIFY_X509_STRICT)
                self.assertTrue(context.verify_flags & ssl.VERIFY_X509_PARTIAL_CHAIN)

    def test_native_tls(self):
        for version in (ssl.TLSVersion.TLSv1_2, ssl.TLSVersion.TLSv1_3):
            with self.subTest(version=version), self.server(version=version) as port:
                context = ssl.create_default_context(cafile=str(self.path / "ca.pem"))
                context.set_alpn_protocols(["http/1.1"])
                with socket.create_connection(("127.0.0.1", port), timeout=5) as sock:
                    with context.wrap_socket(sock, server_hostname="localhost") as tls:
                        self.assertEqual(tls.version(), version.name.replace("_", "."))
                        self.assertEqual(tls.selected_alpn_protocol(), "http/1.1")
                        self.assertIsNone(tls.compression())

    def test_native_rejects_invalid_certificates(self):
        for certificate, trusted in [
            ("wrong", True), ("cn", True), ("expired", True), ("valid", False),
        ]:
            with self.subTest(certificate=certificate), self.server(certificate) as port:
                context = ssl.create_default_context(
                    cafile=str(self.path / "ca.pem") if trusted else None
                )
                context.hostname_checks_common_name = False
                with socket.create_connection(("127.0.0.1", port), timeout=5) as sock:
                    with self.assertRaises(ssl.SSLCertVerificationError):
                        context.wrap_socket(sock, server_hostname="localhost")

    def test_urllib3_tls(self):
        for version in (ssl.TLSVersion.TLSv1_2, ssl.TLSVersion.TLSv1_3):
            with self.subTest(version=version), self.server(version=version) as port:
                with urllib3.HTTPSConnectionPool(
                    "127.0.0.1", port, ca_certs=str(self.path / "ca.pem"),
                    server_hostname="localhost", retries=False, timeout=5,
                ) as pool:
                    self.assertEqual(pool.request("GET", "/").data, b"ok")

    def test_urllib3_rejects_invalid_certificates(self):
        for certificate, trusted in [
            ("wrong", True), ("cn", True), ("expired", True), ("valid", False),
        ]:
            with self.subTest(certificate=certificate, trusted=trusted):
                with self.server(certificate) as port:
                    with urllib3.HTTPSConnectionPool(
                        "127.0.0.1", port,
                        ca_certs=str(self.path / "ca.pem") if trusted else None,
                        server_hostname="localhost", retries=False, timeout=5,
                    ) as pool:
                        with self.assertRaises(urllib3.exceptions.SSLError):
                            pool.request("GET", "/")


if __name__ == "__main__":
    unittest.main(verbosity=2)
