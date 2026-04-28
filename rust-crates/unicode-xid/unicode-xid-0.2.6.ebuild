# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-xid"
CRATE_VERSION="0.2.6"
CRATE_CHECKSUM="ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31."
HOMEPAGE="https://github.com/unicode-rs/unicode-xid"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bench"
	"default"
	"no_std"
)
