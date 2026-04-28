# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="displaydoc"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
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
