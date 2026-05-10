# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rctree"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="3b42e27ef78c35d3998403c1d26f3efd9e135d3e5121b0a4845cc5cc27547f4f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A 'DOM-like' tree implemented using reference counting"
HOMEPAGE="https://github.com/RazrFalcon/rctree"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
