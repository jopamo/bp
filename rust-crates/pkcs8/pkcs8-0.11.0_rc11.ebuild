# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pkcs8"
CRATE_VERSION="0.11.0-rc.11"
CRATE_CHECKSUM="12922b6296c06eb741b02d7b5161e3aaa22864af38dfa025a1a3ba3f68c84577"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementation of Public-Key Cryptography Standards (PKCS) #8: Private-Key Information Syntax Specification (RFC 5208), with additional support for PKCS#8v2 asymmetric key packages (RFC 5958)"
HOMEPAGE="https://github.com/RustCrypto/formats/tree/master/pkcs8"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"3des"
	"alloc"
	"des-insecure"
	"encryption"
	"pem"
	"sha1-insecure"
	"std"
)
