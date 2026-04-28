# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum"
CRATE_VERSION="0.28.0"
CRATE_CHECKSUM="9628de9b8791db39ceda2b119bbe13134770b56c138ec1d3af810d045c04f9bd"
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
