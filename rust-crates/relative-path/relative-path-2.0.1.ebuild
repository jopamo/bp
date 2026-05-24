# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="relative-path"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="bca40a312222d8ba74837cb474edef44b37f561da5f773981007a10bbaa992b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable, relative paths for Rust."
HOMEPAGE="https://github.com/udoprog/relative-path"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
)
