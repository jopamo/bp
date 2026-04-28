# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="x11-clipboard"
CRATE_VERSION="0.9.3"
CRATE_CHECKSUM="662d74b3d77e396b8e5beb00b9cad6a9eccf40b2ef68cc858784b14c41d535a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="x11 clipboard support for Rust."
HOMEPAGE="https://github.com/quininer/x11-clipboard"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
