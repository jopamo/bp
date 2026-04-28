# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling_macro"
CRATE_VERSION="0.20.10"
CRATE_CHECKSUM="d336a2a514f6ccccaa3e09b02d41d35330c07ddf03a62165fcec10bb561c7806"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal support for a proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
