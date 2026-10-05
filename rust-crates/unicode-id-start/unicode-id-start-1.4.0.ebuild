# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-id-start"
CRATE_VERSION="1.4.0"
CRATE_CHECKSUM="81b79ad29b5e19de4260020f8919b443b2ef0277d242ce532ec7b7a2cc8b6007"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the ID_Start or ID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/Boshen/unicode-id-start"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
