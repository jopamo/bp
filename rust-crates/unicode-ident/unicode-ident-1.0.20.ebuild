# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.20"
CRATE_CHECKSUM="462eeb75aeb73aea900253ce739c8e18a67423fadf006037cd3ff27e82748a06"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
