# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen"
CRATE_VERSION="0.45.1"
CRATE_CHECKSUM="5c573471f125075647d03df72e026074b7203790d41351cd6edc96f46bcccd36"
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
	"bitflags"
	"default"
	"macros"
	"realloc"
	"rustc-dep-of-std"
	"std"
)
