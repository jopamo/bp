# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zune-core"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="cb8a0807f7c01457d0379ba880ba6322660448ddebc890ce29bb64da71fb40f9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core utilities for image processing in the zune family of crates"
HOMEPAGE="https://github.com/etemesi254/zune-image"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
