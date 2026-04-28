# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deranged"
CRATE_VERSION="0.3.11"
CRATE_CHECKSUM="b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ranged integers"
HOMEPAGE="https://github.com/jhpratt/deranged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"num"
	"powerfmt"
	"quickcheck"
	"rand"
	"serde"
	"std"
)
