# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen"
CRATE_VERSION="0.51.0"
CRATE_CHECKSUM="d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
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
	"async-spawn"
	"bitflags"
	"default"
	"inter-task-wakeup"
	"macros"
	"realloc"
	"rustc-dep-of-std"
	"std"
)
