# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="idna"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="686f825264d630750a544639377bae737628043f20d38bbc029e8f29ea968a7e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IDNA (Internationalizing Domain Names in Applications) and Punycode."
HOMEPAGE="https://github.com/servo/rust-url/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiled_data"
	"default"
	"std"
)
