# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_locale_data"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="4fdef0c124749d06a743c69e938350816554eb63ac979166590e2b4ee4252765"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data for the icu_locale crate"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
