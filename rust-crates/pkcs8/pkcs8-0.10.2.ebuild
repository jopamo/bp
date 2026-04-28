# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pkcs8"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="f950b2377845cebe5cf8b5165cb3cc1a5e0fa5cfa3e1f7f55707d8fd82e0a7b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Public-Key Cryptography Standards (PKCS) #8: Private-Key Information Syntax Specification (RFC 5208), with additional support for PKCS#8v2 asymmetric key packages (RFC 5958)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/pkcs8"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"3des"
	"alloc"
	"des-insecure"
	"encryption"
	"getrandom"
	"pem"
	"sha1-insecure"
	"std"
)
