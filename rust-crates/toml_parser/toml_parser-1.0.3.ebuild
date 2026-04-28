# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="toml_parser"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="4cf893c33be71572e0e9aa6dd15e6677937abd686b066eac3f8cd3531688a627"
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
