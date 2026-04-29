# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lexical-util"
CRATE_VERSION="1.0.7"
CRATE_CHECKSUM="2604dd126bb14f13fb5d1bd6a66155079cb9fa655b37f875b3a742c705dbed17"
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
	"format"
	"lint"
	"parse-floats"
	"parse-integers"
	"power-of-two"
	"radix"
	"std"
	"write-floats"
	"write-integers"
)
