# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yoke"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="5f41bb01b8226ef4bfd589436a297c53d118f65921786300e427be8d487695cc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Abstraction allowing borrowed data to be carried along with the backing data it borrows from"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"serde"
	"zerofrom"
)
