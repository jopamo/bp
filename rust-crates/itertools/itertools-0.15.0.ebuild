# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="itertools"
CRATE_VERSION="0.15.0"
CRATE_CHECKSUM="8b4baf93f58d4425749ca49a51c50ebab072c5df6994d08fed93541c331481dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extra iterator adaptors, iterator methods, free functions, and macros."
HOMEPAGE="https://github.com/rust-itertools/itertools"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_alloc"
	"use_std"
)
