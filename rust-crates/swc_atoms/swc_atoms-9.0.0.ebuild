# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_atoms"
CRATE_VERSION="9.0.0"
CRATE_CHECKSUM="d4ccbe2ecad10ad7432100f878a107b1d972a8aee83ca53184d00c23a078bb8a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Atoms for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__rkyv"
	"encoding-impl"
	"rkyv-impl"
	"shrink-to-fit"
)
