# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="wasite"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="66fe902b4a6b8028a753d5424909b764ccf79b7a209eac9bf97e59cda9f71a42"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASI Terminal Environment API"
HOMEPAGE="https://github.com/ardaku/wasite/releases"
LICENSE="|| ( Apache-2.0 BSL-1.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
