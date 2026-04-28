# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand_xorshift"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="cbf7e9e623549b0e21f6e97cf8ecf247c1a8fd2e8a992ae265314300b2455d5c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Xorshift random number generator"
HOMEPAGE="https://crates.io/crates/rand_xorshift"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"serde1"
)
