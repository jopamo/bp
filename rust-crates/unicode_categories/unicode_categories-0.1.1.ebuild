# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode_categories"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="39ec24b3121d976906ece63c9daad25b85969647682eee313cb5779fdd69e14e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Query Unicode category membership for chars"
HOMEPAGE="https://github.com/swgillespie/unicode-categories"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
