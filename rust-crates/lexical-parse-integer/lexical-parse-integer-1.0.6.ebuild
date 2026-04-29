# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lexical-parse-integer"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="9a7a039f8fb9c19c996cd7b2fcce303c1b2874fe1aca544edc85c4a5f8489b34"
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
