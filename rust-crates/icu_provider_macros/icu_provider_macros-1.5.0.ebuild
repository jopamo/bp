# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_provider_macros"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="1ec89e9337638ecdc08744df490b221a7399bf8d164eb52a665454e60e075ad6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for ICU data providers"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
