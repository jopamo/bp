# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ast_node"
CRATE_VERSION="3.0.4"
CRATE_CHECKSUM="0a184645bcc6f52d69d8e7639720699c6a99efb711f886e251ed1d16db8dd90e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for ast nodes."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
