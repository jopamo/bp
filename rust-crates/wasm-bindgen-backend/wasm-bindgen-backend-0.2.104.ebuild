# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-bindgen-backend"
CRATE_VERSION="0.2.104"
CRATE_CHECKSUM="671c9a5a66f49d8a47345ab942e2cb93c7d1d0339065d4f8139c486121b43b19"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend code generation of the wasm-bindgen tool"
HOMEPAGE="https://wasm-bindgen.github.io/wasm-bindgen/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"extra-traits"
)
