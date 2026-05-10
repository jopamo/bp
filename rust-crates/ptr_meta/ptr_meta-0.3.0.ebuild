# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ptr_meta"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="fe9e76f66d3f9606f44e45598d155cb13ecf09f4a28199e48daf8c8fc937ea90"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A radioactive stabilization of the ptr_meta rfc"
HOMEPAGE="https://github.com/rkyv/ptr_meta"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"std"
)
