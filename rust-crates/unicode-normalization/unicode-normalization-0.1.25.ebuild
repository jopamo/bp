# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-normalization"
CRATE_VERSION="0.1.25"
CRATE_CHECKSUM="5fd4f6878c9cb28d874b009da9e8d183b5abc80117c40bbd187a1fde336be6e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate provides functions for normalization of Unicode strings, including Canonical and Compatible Decomposition and Recomposition, as described in Unicode Standard Annex #15."
HOMEPAGE="https://github.com/unicode-rs/unicode-normalization"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
