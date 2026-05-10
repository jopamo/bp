# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="spdx"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="afd765179d12cdd06192e02b1d8c6b0d46bd26de9bf16ce04c881428ca2cc7ed"
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
