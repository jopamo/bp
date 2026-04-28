# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="termtree"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="8f50febec83f5ee1df3015341d8bd429f2d1cc62bcba7ea2076759d315084683"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Visualize tree-like data on the command-line"
HOMEPAGE="https://github.com/rust-cli/termtree"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
