# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_pcg"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="abf9b09b01790cfe0364f52bf32995ea3c39f4d2dd011eac241d2914146d0b44"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Selected PCG random number generators"
HOMEPAGE="https://crates.io/crates/rand_pcg"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
