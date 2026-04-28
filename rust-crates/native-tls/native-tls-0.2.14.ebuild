# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="native-tls"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="87de3442987e9dbec73158d5c715e7ad9072fda936bb03d19d7fa10e00520f0e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A wrapper over a platform's native TLS implementation"
HOMEPAGE="https://github.com/sfackler/rust-native-tls"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alpn"
	"vendored"
)
