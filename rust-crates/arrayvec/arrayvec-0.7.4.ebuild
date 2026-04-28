# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="arrayvec"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="96d30a06541fbafbc7f82ed10c06164cfbd2c401138f6addd8404629c4b16711"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A vector with fixed capacity, backed by an array (it can be stored on the stack too). Implements fixed capacity ArrayVec and ArrayString."
HOMEPAGE="https://github.com/bluss/arrayvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
