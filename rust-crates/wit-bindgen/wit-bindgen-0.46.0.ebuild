# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen"
CRATE_VERSION="0.46.0"
CRATE_CHECKSUM="f17a85883d4e6d00e8a97c586de764dabcc06133f7f1d55dce5cdc070ad7fe59"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings generator and runtime support for WIT and the component model. Used when compiling Rust programs to the component model."
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"async"
	"bitflags"
	"default"
	"macros"
	"realloc"
	"rustc-dep-of-std"
	"std"
)
