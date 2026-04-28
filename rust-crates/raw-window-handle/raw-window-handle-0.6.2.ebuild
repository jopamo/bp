# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="raw-window-handle"
CRATE_VERSION="0.6.2"
CRATE_CHECKSUM="20675572f6f24e9e76ef639bc5552774ed45f1c30e2951e1e99c59888861c539"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Interoperability library for Rust Windowing applications."
HOMEPAGE="https://github.com/rust-windowing/raw-window-handle"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"std"
	"wasm-bindgen-0-2"
)
