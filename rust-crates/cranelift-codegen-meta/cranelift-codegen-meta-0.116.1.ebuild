# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cranelift-codegen-meta"
CRATE_VERSION="0.116.1"
CRATE_CHECKSUM="c904bc71c61b27fc57827f4a1379f29de64fe95653b620a3db77d59655eee0b8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Metaprogram for cranelift-codegen code generator library"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"pulley"
)
