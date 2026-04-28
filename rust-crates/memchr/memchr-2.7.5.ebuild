# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memchr"
CRATE_VERSION="2.7.5"
CRATE_CHECKSUM="32a282da65faaf38286cf3be983213fcf1d2e2a58700e808f83f4ea9a4804bc0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides extremely fast (uses SIMD on x86_64, aarch64 and wasm32) routines for 1, 2 or 3 byte search and single substring search."
HOMEPAGE="https://github.com/BurntSushi/memchr"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"libc"
	"logging"
	"rustc-dep-of-std"
	"std"
	"use_std"
)
