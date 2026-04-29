# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum"
CRATE_VERSION="0.27.2"
CRATE_CHECKSUM="af23d6f6c1a224baef9d3f61e287d2761385a5b88fdab4eb4c6f11aeb54c4bcf"
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
