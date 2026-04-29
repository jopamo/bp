# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="lexical-parse-integer"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="72207aae22fc0a121ba7b6d479e42cbfea549af1479c3f3a4f12c70dd66df12e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient parsing of integers from strings."
HOMEPAGE="https://github.com/Alexhuszagh/rust-lexical"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compact"
	"default"
	"format"
	"lint"
	"power-of-two"
	"radix"
	"std"
)
