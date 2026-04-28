# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pest"
CRATE_VERSION="2.7.15"
CRATE_CHECKSUM="8b7cafe60d6cf8e62e1b9b2ea516a089c008945bb5a275416789e7db0bc199dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The Elegant Parser"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_prec_climber"
	"default"
	"miette-error"
	"pretty-print"
	"std"
)
