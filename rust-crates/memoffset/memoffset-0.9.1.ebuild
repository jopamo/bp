# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memoffset"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="488016bfae457b036d996092f6cb448677611ce4449e970ceaf42695203f218a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="offset_of functionality for Rust structs."
HOMEPAGE="https://github.com/Gilnaa/memoffset"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"unstable_const"
	"unstable_offset_of"
)
