# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tokio-rustls"
CRATE_VERSION="0.26.4"
CRATE_CHECKSUM="1729aa945f29d91ba541258c8df89027d5792d85a8841fb65e8bf0f4ede4ef61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Asynchronous TLS/SSL streams for Tokio using Rustls."
HOMEPAGE="https://github.com/rustls/tokio-rustls"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"aws_lc_rs"
	"brotli"
	"default"
	"early-data"
	"fips"
	"logging"
	"ring"
	"tls12"
	"zlib"
)
