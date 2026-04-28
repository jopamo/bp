# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="validator"
CRATE_VERSION="0.19.0"
CRATE_CHECKSUM="d0b4a29d8709210980a09379f27ee31549b73292c87ab9899beee1c0d3be6303"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common validation functions (email, url, length, ...) and trait - to be used with \`validator_derive\`"
HOMEPAGE="https://github.com/Keats/validator"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"card"
	"derive"
	"derive_nightly_features"
	"unic"
)
