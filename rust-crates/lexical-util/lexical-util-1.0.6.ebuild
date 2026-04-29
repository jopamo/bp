# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lexical-util"
CRATE_VERSION="1.0.6"
CRATE_CHECKSUM="5a82e24bf537fd24c177ffbbdc6ebcc8d54732c35b50a3f28cc3f4e4c949a0b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared utilities for lexical creates."
HOMEPAGE="https://github.com/Alexhuszagh/rust-lexical"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compact"
	"default"
	"f128"
	"f16"
	"floats"
	"format"
	"integers"
	"lint"
	"parse"
	"parse-floats"
	"parse-integers"
	"power-of-two"
	"radix"
	"std"
	"write"
	"write-floats"
	"write-integers"
)
