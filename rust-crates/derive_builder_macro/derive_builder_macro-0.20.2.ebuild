# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive_builder_macro"
CRATE_VERSION="0.20.2"
CRATE_CHECKSUM="ab63b0e2bf4d5928aff72e83a7dace85d7bba5fe12dcc3c5a572d78caffd3f3c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust macro to automatically implement the builder pattern for arbitrary structs."
HOMEPAGE="https://github.com/colin-kiegel/rust-derive-builder"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"clippy"
	"lib_has_std"
)
