# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libc"
CRATE_VERSION="0.2.169"
CRATE_CHECKSUM="b5aba8db14291edd000dfcc4d620c7ebfb122c613afb886ca8803fa4e128a20a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw FFI bindings to platform libraries like libc."
HOMEPAGE="https://github.com/rust-lang/libc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"align"
	"const-extern-fn"
	"default"
	"extra_traits"
	"rustc-dep-of-std"
	"std"
	"use_std"
)
