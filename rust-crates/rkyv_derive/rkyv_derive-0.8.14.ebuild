# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rkyv_derive"
CRATE_VERSION="0.8.14"
CRATE_CHECKSUM="7c02f8cdd12b307ab69fe0acf4cd2249c7460eb89dce64a0febadf934ebb6a9e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for rkyv"
HOMEPAGE="https://github.com/rkyv/rkyv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bytecheck"
	"default"
)
