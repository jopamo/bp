# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cfg-if"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="9555578bc9e57714c812a1f84e4fc5b4d21fcb063490c624de019f7464c91268"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to ergonomically define an item depending on a large number of #[cfg] parameters. Structured like an if-else chain, the first matching branch is the item that gets emitted."
HOMEPAGE="https://github.com/rust-lang/cfg-if"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
)
