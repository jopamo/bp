# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_parser"
CRATE_VERSION="1.0.6+spec-1.1.0"
CRATE_CHECKSUM="a3198b4b0a8e11f09dd03e133c0280504d0801269e9afa46362ffde1cbeebf44"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debug"
	"default"
	"simd"
	"std"
	"unsafe"
)
