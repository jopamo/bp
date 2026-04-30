# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libc"
CRATE_VERSION="0.2.185"
CRATE_CHECKSUM="52ff2c0fe9bc6cb6b14a0592c2ff4fa9ceb83eea9db979b0487cd054946a2b8f"
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
