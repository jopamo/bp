# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glob"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="0cc23270f6e1808e30a928bdc84dea0b9b4136a8bc82338574f23baf47bbd280"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support for matching file paths against Unix shell style patterns."
HOMEPAGE="https://github.com/rust-lang/glob"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
