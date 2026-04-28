# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum"
CRATE_VERSION="0.27.1"
CRATE_CHECKSUM="f64def088c51c9510a8579e3c5d67c65349dcf755e5479ad3d010aa6454e2c32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helpful macros for working with enums and strings"
HOMEPAGE="https://github.com/Peternator7/strum"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"std"
)
