# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rand"
CRATE_VERSION="0.6.5"
CRATE_CHECKSUM="6d71dacdc3c88c1fde3885a3be3fbab9f35724e6ce99467f7d9c5026132184ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Random number generators and other randomness functionality."
HOMEPAGE="https://crates.io/crates/rand"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"i128_support"
	"nightly"
	"serde1"
	"simd_support"
	"std"
	"stdweb"
	"wasm-bindgen"
)
