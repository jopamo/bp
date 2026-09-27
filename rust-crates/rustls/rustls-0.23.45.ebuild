# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustls"
CRATE_VERSION="0.23.45"
CRATE_CHECKSUM="0d41d731c7d2f962d1ccc364cec258de3c0e93b38c2fb3ba97ac74513048d634"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustls is a modern TLS library written in Rust."
HOMEPAGE="https://github.com/rustls/rustls"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"aws_lc_rs"
	"brotli"
	"custom-provider"
	"default"
	"fips"
	"logging"
	"prefer-post-quantum"
	"read_buf"
	"ring"
	"std"
	"tls12"
	"zlib"
)
