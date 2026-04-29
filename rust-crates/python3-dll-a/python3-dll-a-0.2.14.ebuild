# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="python3-dll-a"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="d381ef313ae70b4da5f95f8a4de773c6aa5cd28f73adec4b4a31df70b66780d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Standalone python3(y)(t).dll import library generator"
HOMEPAGE="https://github.com/PyO3/python3-dll-a"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
