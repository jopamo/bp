# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="esaxx-rs"
CRATE_VERSION="0.1.10"
CRATE_CHECKSUM="d817e038c30374a4bcb22f94d0a8a0e216958d4c3dcde369b1439fec4bdda6e6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrapping around sentencepiece's esaxxx library."
HOMEPAGE="https://github.com/Narsil/esaxx-rs"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cpp"
	"default"
)
