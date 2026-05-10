# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rancor"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="a063ea72381527c2a0561da9c80000ef822bdd7c3241b1cc1b12100e3df081ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Scalable and efficient error handling without type composition"
HOMEPAGE="https://github.com/rkyv/rancor"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
)
