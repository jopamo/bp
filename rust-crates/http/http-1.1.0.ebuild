# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="http"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="21b9ddb458710bc376481b842f5da65cdf31522de232c1ca8146abce2a358258"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A set of types for representing HTTP requests and responses."
HOMEPAGE="https://github.com/hyperium/http"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
