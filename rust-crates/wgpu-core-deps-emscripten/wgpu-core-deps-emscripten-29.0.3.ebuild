# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-core-deps-emscripten"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="3487cd6293a963bc5c0c0396f6a2192043c50003c07f4efdccbad3d90ec9d819"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature unification helper crate for the Emscripten platform"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"gles"
)
