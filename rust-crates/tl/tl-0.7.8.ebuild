# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tl"
CRATE_VERSION="0.7.8"
CRATE_CHECKSUM="04466af1c82da5a1095acdecb8ece18439343f9d39b0a1bb697c53de03358f9d"
CRATE_SOURCE="git+https://github.com/astral-sh/tl.git?rev=6e25b2ee2513d75385101a8ff9f591ef51f314ec#6e25b2ee2513d75385101a8ff9f591ef51f314ec"
CRATE_SOURCE_KIND="git"

inherit cargo-crate

DESCRIPTION="Fast HTML parser written in pure Rust"
HOMEPAGE="https://github.com/y21/tl"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__INTERNALS_DO_NOT_USE"
	"simd"
)
