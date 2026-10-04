# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand"
CRATE_VERSION="0.10.3"
CRATE_CHECKSUM="65c9fb96cbc91e3478eaae79a69fcd3f1ae4ad052e471fe6732fff548984b4af"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generators and other randomness functionality."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"chacha"
	"default"
	"log"
	"serde"
	"simd_support"
	"std"
	"std_rng"
	"sys_rng"
	"thread_rng"
	"unbiased"
)
