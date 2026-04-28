# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="http-body"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="7ceab25649e9960c0311ea418d17bee82c0dcec1bd053b5f9a66e265a693bed2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait representing an asynchronous, streaming, HTTP request or response body."
HOMEPAGE="https://github.com/hyperium/http-body"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
