# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="new_debug_unreachable"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="650eef8c711430f1a879fdd01d4745a7deea475becfb90269c06775983bbf086"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="panic in debug, intrinsics::unreachable() in release (fork of debug_unreachable)"
HOMEPAGE="https://github.com/mbrubeck/rust-debug-unreachable"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
