# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libc"
CRATE_VERSION="0.2.180"
CRATE_CHECKSUM="bcc35a38544a891a5f7c865aca548a982ccb3b8650a5b06d0fd33a10283c56fc"
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
