# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="equator"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="4711b213838dfee0117e3be6ac926007d7f433d7bbe33595975d4190cb07e6fc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Composable assertion library"
HOMEPAGE="https://github.com/sarah-ek/equator/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
