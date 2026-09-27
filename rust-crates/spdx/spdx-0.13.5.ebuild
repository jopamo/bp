# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="spdx"
CRATE_VERSION="0.13.5"
CRATE_CHECKSUM="081670c233dfbed55690cc0cd38424e0e24ac1b2673d0b408b3f7b684738dfa9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for SPDX expressions"
HOMEPAGE="https://github.com/EmbarkStudios/spdx"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"detection"
	"detection-cache"
	"detection-inline-cache"
	"detection-parallel"
	"std"
	"text"
)
