# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yoke"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="72d6e5c6afb84d73944e5cedb052c4680d5657337201555f9f2a16b7406d4954"
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
