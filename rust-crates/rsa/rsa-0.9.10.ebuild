# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rsa"
CRATE_VERSION="0.9.10"
CRATE_CHECKSUM="b8573f03f5883dcaebdfcf4725caa1ecb9c15b2ef50c43a07b816e06799bb12d"
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
