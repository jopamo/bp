# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="capacity_builder"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="8f2d24a6dcf0cd402a21b65d35340f3a49ff3475dc5fdac91d22d2733e6641c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Builders where the code to calculate the capacity is the same as the code to write what's being built."
HOMEPAGE="https://github.com/dsherret/capacity_builder"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ecow"
	"hipstr"
)
