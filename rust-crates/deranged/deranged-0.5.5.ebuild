# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deranged"
CRATE_VERSION="0.5.5"
CRATE_CHECKSUM="ececcb659e7ba858fb4f10388c250a7252eb0a27373f1a72b8748afdd248e587"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ranged integers"
HOMEPAGE="https://github.com/jhpratt/deranged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"macros"
	"num"
	"powerfmt"
	"quickcheck"
	"rand"
	"rand08"
	"rand09"
	"serde"
)
