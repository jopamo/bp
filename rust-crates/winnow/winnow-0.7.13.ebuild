# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winnow"
CRATE_VERSION="0.7.13"
CRATE_CHECKSUM="21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A byte-oriented, zero-copy, parser combinators library"
HOMEPAGE="https://github.com/winnow-rs/winnow"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debug"
	"default"
	"simd"
	"std"
	"unstable-doc"
	"unstable-recover"
)
