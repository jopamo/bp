# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="memchr"
CRATE_VERSION="2.8.2"
CRATE_CHECKSUM="88904434abc2901f197fe8cc55f0445e7ded921dba5911dad2e2b39b48e663c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides extremely fast (uses SIMD on x86_64, aarch64 and wasm32) routines for 1, 2 or 3 byte search and single substring search."
HOMEPAGE="https://github.com/BurntSushi/memchr"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
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
