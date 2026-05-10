# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-rustls"
CRATE_VERSION="0.26.2"
CRATE_CHECKSUM="8e727b36a1a0e8b74c376ac2211e40c2c8af09fb4013c60d910495810f008e9b"
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
	"default"
	"early-data"
	"fips"
	"logging"
	"ring"
	"tls12"
)
