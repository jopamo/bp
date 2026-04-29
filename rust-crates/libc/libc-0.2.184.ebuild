# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libc"
CRATE_VERSION="0.2.184"
CRATE_CHECKSUM="48f5d2a454e16a5ea0f4ced81bd44e4cfc7bd3a507b61887c99fd3538b28e4af"
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
