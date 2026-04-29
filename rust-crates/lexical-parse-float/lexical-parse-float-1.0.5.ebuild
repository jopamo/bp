# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="lexical-parse-float"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="de6f9cb01fb0b08060209a057c048fcbab8717b4c1ecd2eac66ebfe39a65b0f2"
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
