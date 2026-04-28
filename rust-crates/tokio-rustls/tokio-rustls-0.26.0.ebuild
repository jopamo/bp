# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-rustls"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="0c7bc40d0e5a97695bb96e27995cd3a08538541b0a846f65bba7a359f36700d4"
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
