# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="equator-macro"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="44f23cf4b44bfce11a86ace86f8a73ffdec849c9fd00a386a53d278bd9e81fb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Composable assertion library"
HOMEPAGE="https://github.com/sarah-ek/equator/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
