# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="http-body"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="1efedce1fb8e6913f23e0c92de8e62cd5b772a67e7b3946df930a62566c93184"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait representing an asynchronous, streaming, HTTP request or response body."
HOMEPAGE="https://github.com/hyperium/http-body"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
