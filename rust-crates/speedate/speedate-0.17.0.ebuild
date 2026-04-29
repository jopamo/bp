# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="speedate"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="aba069c070b5e213f2a094deb7e5ed50ecb092be36102a4f4042e8d2056d060e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast and simple datetime, date, time and duration parsing"
HOMEPAGE="https://github.com/pydantic/speedate/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
