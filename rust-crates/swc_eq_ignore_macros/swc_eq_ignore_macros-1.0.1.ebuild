# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_eq_ignore_macros"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="c16ce73424a6316e95e09065ba6a207eba7765496fed113702278b7711d4b632"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for EqIgnoreSpan and TypeEq."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
