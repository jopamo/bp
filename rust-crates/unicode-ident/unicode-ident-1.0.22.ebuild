# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.22"
CRATE_CHECKSUM="9312f7c4f6ff9069b165498234ce8be658059c6728633667c526e27dc2cf1df5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
