# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="kurbo"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="7564e90fe3c0d5771e1f0bc95322b21baaeaa0d9213fa6a0b61c99f8b17b3bfb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A 2D curves library"
HOMEPAGE="https://github.com/linebender/kurbo"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"euclid"
	"libm"
	"mint"
	"schemars"
	"serde"
	"std"
)
