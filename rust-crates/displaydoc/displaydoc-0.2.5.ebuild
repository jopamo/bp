# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="displaydoc"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A derive macro for implementing the display Trait via a doc comment and string interpolation"
HOMEPAGE="https://github.com/yaahc/displaydoc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
