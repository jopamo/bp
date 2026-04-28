# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="ade2d8b8f33c7333b51bcf0428d37e217e9f32192ae4772156f65063b8ce03dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Runtime support for perfect hash function data structures"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"macros"
	"std"
	"uncased"
	"unicase"
)
