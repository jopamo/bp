# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hyper-rustls"
CRATE_VERSION="0.27.2"
CRATE_CHECKSUM="5ee4be2c948921a1a5320b629c4193916ed787a7f7f293fd3f7f5a6c9de74155"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustls+hyper integration for pure rust HTTPS"
HOMEPAGE="https://github.com/rustls/hyper-rustls"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
