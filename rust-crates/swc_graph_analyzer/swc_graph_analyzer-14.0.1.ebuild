# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_graph_analyzer"
CRATE_VERSION="14.0.1"
CRATE_CHECKSUM="a42314199595da31f253f6ea4dd3d67e9ed0a5745d0b07dad11de200b4ae9336"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Graph analyzer"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
