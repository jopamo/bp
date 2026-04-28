# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wit-bindgen-rust"
CRATE_VERSION="0.51.0"
CRATE_CHECKSUM="b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings generator for WIT and the component model, typically used through the `wit-bindgen` crate's `generate!` macro."
HOMEPAGE="https://github.com/bytecodealliance/wit-bindgen"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"clap"
	"serde"
)
