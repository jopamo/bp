# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hstr"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="31f11d91d7befd2ffd9d216e9e5ea1fae6174b20a2a1b67a688138003d2f4122"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A string type which is optimized for hash operations."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"atom_size_128"
	"atom_size_64"
	"rkyv"
	"serde"
)
