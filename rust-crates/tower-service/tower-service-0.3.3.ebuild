# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tower-service"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="8df9b6e13f2d32c91b9bd719c00d1958837bc7dec474d94952798cc8e69eeec3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait representing an asynchronous, request / response based, client or server."
HOMEPAGE="https://github.com/tower-rs/tower"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
