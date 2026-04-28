# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand"
CRATE_VERSION="0.8.5"
CRATE_CHECKSUM="34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generators and other randomness functionality."
HOMEPAGE="https://rust-random.github.io/book"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"getrandom"
	"min_const_gen"
	"nightly"
	"serde1"
	"simd_support"
	"small_rng"
	"std"
	"std_rng"
)
