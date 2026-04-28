# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-query"
CRATE_VERSION="1.1.4"
CRATE_CHECKSUM="9e231f6134f61b71076a3eab506c379d4f36122f2af15a9ff04415ea4c3339e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Look up colored console capabilities"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
