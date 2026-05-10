# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-tl"
CRATE_VERSION="0.7.11"
CRATE_CHECKSUM="d90933ffb0f97e2fc2e0de21da9d3f20597b804012d199843a6fe7c2810d28f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast HTML parser written in pure Rust"
HOMEPAGE="https://github.com/astral-sh/astral-tl"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__INTERNALS_DO_NOT_USE"
)
