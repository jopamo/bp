# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cfg_aliases"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="f079e83a288787bcd14a6aea84cee5c87a67c5a3e660c30f557a3d24761b3527"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny utility to help save you a lot of effort with long winded \`#[cfg()]\` checks."
HOMEPAGE="https://github.com/katharostech/cfg_aliases"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
