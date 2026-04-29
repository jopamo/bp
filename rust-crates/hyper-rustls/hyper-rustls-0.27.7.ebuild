# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="hyper-rustls"
CRATE_VERSION="0.27.7"
CRATE_CHECKSUM="e3c93eb611681b207e1fe55d5a71ecf91572ec8a6705cdb6857f7d8d5242cf58"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustls+hyper integration for pure rust HTTPS"
HOMEPAGE="https://github.com/rustls/hyper-rustls"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"default"
	"fips"
	"http1"
	"http2"
	"logging"
	"native-tokio"
	"ring"
	"tls12"
	"webpki-tokio"
)
