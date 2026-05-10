# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="version-ranges"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="c97605846bf3369fabe81e5b26f11bba4db517ad5eecb151dbe4a9c7616f7d7a"
CRATE_SOURCE="git+https://github.com/astral-sh/pubgrub?rev=d8efd77673c9a90792da9da31b6c0da7ea8a324b#d8efd77673c9a90792da9da31b6c0da7ea8a324b"
CRATE_SOURCE_KIND="git"

inherit cargo-crate

DESCRIPTION="Performance-optimized type for generic version ranges and operations on them."
HOMEPAGE="https://github.com/pubgrub-rs/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
