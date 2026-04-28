# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="http"
CRATE_VERSION="0.2.12"
CRATE_CHECKSUM="601cbb57e577e2f5ef5be8e7b83f0f63994f25aa94d673e54a92d5c516d101f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A set of types for representing HTTP requests and responses."
HOMEPAGE="https://github.com/hyperium/http"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
