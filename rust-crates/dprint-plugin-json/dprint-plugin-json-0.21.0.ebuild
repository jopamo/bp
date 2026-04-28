# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-plugin-json"
CRATE_VERSION="0.21.0"
CRATE_CHECKSUM="44eda084193a0bfff508f408db288d6d7dc889d56aa3ecbbe8ac47f005b35cb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JSON formatter for dprint."
HOMEPAGE="https://github.com/dprint/dprint-plugin-json"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"tracing"
	"wasm"
)
