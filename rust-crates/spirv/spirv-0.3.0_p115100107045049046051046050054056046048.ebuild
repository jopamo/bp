# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="spirv"
CRATE_VERSION="0.3.0+sdk-1.3.268.0"
CRATE_CHECKSUM="eda41003dc44290527a59b13432d4a0379379fa074b70174882adfbdfd917844"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust definition of SPIR-V structs and enums"
HOMEPAGE="https://github.com/gfx-rs/rspirv"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"deserialize"
	"serialize"
)
