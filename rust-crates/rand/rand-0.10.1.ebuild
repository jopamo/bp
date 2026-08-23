# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rand"
CRATE_VERSION="0.10.1"
CRATE_CHECKSUM="d2e8e8bcc7961af1fdac401278c6a831614941f6164ee3bf4ce61b7edb162207"
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
