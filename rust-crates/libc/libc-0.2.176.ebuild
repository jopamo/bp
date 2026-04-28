# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libc"
CRATE_VERSION="0.2.176"
CRATE_CHECKSUM="58f929b4d672ea937a23a1ab494143d968337a5f47e56d0815df1e0890ddf174"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw FFI bindings to platform libraries like libc."
HOMEPAGE="https://github.com/rust-lang/libc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"align"
	"const-extern-fn"
	"default"
	"extra_traits"
	"rustc-dep-of-std"
	"std"
	"use_std"
)
