# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="proptest"
CRATE_VERSION="1.9.0"
CRATE_CHECKSUM="bee689443a2bd0a16ab0348b52ee43e3b2d1b1f931c8aa5c9f8de4c86fbe8c40"
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
	"fork"
	"handle-panics"
	"hardware-rng"
	"no_std"
	"std"
	"timeout"
	"unstable"
)
