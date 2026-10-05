# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="glow"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="29038e1c483364cc6bb3cf78feee1816002e127c331a1eec55a4d202b9e1adb5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="GL on Whatever: a set of bindings to run GL (Open GL, OpenGL ES, and WebGL) anywhere, and avoid target-specific code."
HOMEPAGE="https://github.com/grovesNL/glow.git"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug_automatic_glGetError"
	"debug_trace_calls"
)
