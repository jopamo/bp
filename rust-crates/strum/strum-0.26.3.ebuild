# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum"
CRATE_VERSION="0.26.3"
CRATE_CHECKSUM="8fec0f0aef304996cf250b31b5a10dee7980c85da9d759361292b8bca5a18f06"
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
