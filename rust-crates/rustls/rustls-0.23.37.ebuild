# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="rustls"
CRATE_VERSION="0.23.37"
CRATE_CHECKSUM="758025cb5fccfd3bc2fd74708fd4682be41d99e5dff73c377c0646c6012c73a4"
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
