# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-plugin-typescript"
CRATE_VERSION="0.95.11"
CRATE_CHECKSUM="74aa5df06eb156f7df91bf17a0ca65fd349dfa22463c3eab0a019bab20df12df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="TypeScript and JavaScript code formatter."
HOMEPAGE="https://github.com/dprint/dprint-plugin-typescript"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"tracing"
	"wasm"
)
