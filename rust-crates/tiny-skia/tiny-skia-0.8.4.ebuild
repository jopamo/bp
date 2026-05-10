# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tiny-skia"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="df8493a203431061e901613751931f047d1971337153f96d0e5e363d6dbf6a67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny Skia subset ported to Rust."
HOMEPAGE="https://github.com/RazrFalcon/tiny-skia"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no-std-float"
	"png-format"
	"simd"
	"std"
)
