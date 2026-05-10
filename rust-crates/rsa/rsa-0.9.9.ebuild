# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rsa"
CRATE_VERSION="0.9.9"
CRATE_CHECKSUM="40a0376c50d0358279d9d643e4bf7b7be212f1f4ff1da9070a7b54d22ef75c88"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust RSA implementation"
HOMEPAGE="https://github.com/RustCrypto/RSA"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"getrandom"
	"hazmat"
	"nightly"
	"pem"
	"pkcs5"
	"serde"
	"std"
	"u64_digit"
)
