# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="resolv-conf"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="52e44394d2086d010551b14b53b1f24e31647570cd1deb0379e2c21b329aba00"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The resolv.conf file parser"
HOMEPAGE="http://github.com/tailhook/resolv-conf"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"system"
)
