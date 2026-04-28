# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quote"
CRATE_VERSION="1.0.42"
CRATE_CHECKSUM="a338cc41d27e6cc6dce6cefc13a0729dfbb81c262b1f519331575dd80ef3067f"
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
