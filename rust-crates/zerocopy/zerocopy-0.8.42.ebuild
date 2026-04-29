# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="zerocopy"
CRATE_VERSION="0.8.42"
CRATE_CHECKSUM="f2578b716f8a7a858b7f02d5bd870c14bf4ddbbcf3a4c05414ba6503640505e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zerocopy makes zero-cost memory manipulation effortless. We write \"unsafe\" so you don't have to."
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__internal_use_only_features_that_work_on_stable"
	"alloc"
	"derive"
	"float-nightly"
	"simd"
	"simd-nightly"
	"std"
)
