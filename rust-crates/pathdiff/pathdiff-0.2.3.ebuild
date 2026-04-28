# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pathdiff"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="df94ce210e5bc13cb6651479fa48d14f601d9858cfe0467f43ae157023b938d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for diffing paths to obtain relative paths"
HOMEPAGE="https://github.com/Manishearth/pathdiff"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
