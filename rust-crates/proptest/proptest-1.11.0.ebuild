# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="proptest"
CRATE_VERSION="1.11.0"
CRATE_CHECKSUM="4b45fcc2344c680f5025fe57779faef368840d0bd1f42f216291f0dc4ace4744"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hypothesis-like property-based testing and shrinking."
HOMEPAGE="https://proptest-rs.github.io/proptest/proptest/index.html"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"atomic64bit"
	"attr-macro"
	"bit-set"
	"default"
	"default-code-coverage"
	"f16"
	"fork"
	"handle-panics"
	"hardware-rng"
	"no_std"
	"std"
	"timeout"
	"unstable"
)
