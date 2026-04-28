# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="raw-window-handle"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="8cc3bcbdb1ddfc11e700e62968e6b4cc9c75bb466464ad28fb61c5b2c964418b"
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
