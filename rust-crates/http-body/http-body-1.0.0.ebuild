# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="http-body"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="1cac85db508abc24a2e48553ba12a996e87244a0395ce011e62b37158745d643"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait representing an asynchronous, streaming, HTTP request or response body."
HOMEPAGE="https://github.com/hyperium/http-body"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
