# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lexical-parse-float"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="52a9f232fbd6f550bc0137dcb5f99ab674071ac2d690ac69704593cb4abbea56"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient parsing of floats from strings."
HOMEPAGE="https://github.com/Alexhuszagh/rust-lexical"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compact"
	"default"
	"f128"
	"f16"
	"format"
	"lint"
	"power-of-two"
	"radix"
	"std"
)
