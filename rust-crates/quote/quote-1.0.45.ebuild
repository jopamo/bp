# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quote"
CRATE_VERSION="1.0.45"
CRATE_CHECKSUM="41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quasi-quoting macro quote!(...)"
HOMEPAGE="https://github.com/dtolnay/quote"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
