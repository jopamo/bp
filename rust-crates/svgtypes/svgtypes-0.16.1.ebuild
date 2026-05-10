# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="svgtypes"
CRATE_VERSION="0.16.1"
CRATE_CHECKSUM="695b5790b3131dafa99b3bbfd25a216edb3d216dad9ca208d4657bfb8f2abc3d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SVG types parser."
HOMEPAGE="https://github.com/linebender/svgtypes"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libm"
	"std"
)
