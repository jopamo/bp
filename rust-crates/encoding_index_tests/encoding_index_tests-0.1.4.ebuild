# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding_index_tests"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="a246d82be1c9d791c5dfde9a2bd045fc3cbba3fa2b11ad558f27d01712f00569"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper macros used to test index tables for character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
