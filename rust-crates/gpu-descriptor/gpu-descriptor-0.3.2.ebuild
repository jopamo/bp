# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gpu-descriptor"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="b89c83349105e3732062a895becfc71a8f921bb71ecbbdd8ff99263e3b53a0ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation agnostic descriptor allocator for Vulkan like APIs"
HOMEPAGE="https://github.com/zakarumych/gpu-descriptor"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
