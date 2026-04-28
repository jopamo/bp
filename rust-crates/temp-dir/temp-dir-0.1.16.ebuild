# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="temp-dir"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="83176759e9416cf81ee66cb6508dbfe9c96f20b8b56265a39917551c23c70964"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple temporary directory with cleanup"
HOMEPAGE="https://gitlab.com/leonhard-llc/ops"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
