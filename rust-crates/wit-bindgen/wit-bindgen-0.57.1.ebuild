# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wit-bindgen"
CRATE_VERSION="0.57.1"
CRATE_CHECKSUM="1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings generator and runtime support for WIT and the component model. Used when compiling Rust programs to the component model."
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"async-spawn"
	"bitflags"
	"default"
	"futures-stream"
	"inter-task-wakeup"
	"macro-string"
	"macros"
	"realloc"
	"rustc-dep-of-std"
	"std"
)
