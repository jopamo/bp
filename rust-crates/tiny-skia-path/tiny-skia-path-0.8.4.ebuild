# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tiny-skia-path"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="adbfb5d3f3dd57a0e11d12f4f13d4ebbbc1b5c15b7ab0a156d030b21da5f677c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny-skia Bezier path implementation"
HOMEPAGE="https://github.com/RazrFalcon/tiny-skia/path"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no-std-float"
	"std"
)
