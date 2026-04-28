# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm_dep_analyzer"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="a10e6b67c951a84de7029487e0e0a496860dae49f6699edd279d5ff35b8fbf54"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wasm module dependency analysis for module resolution"
HOMEPAGE="https://github.com/denoland/wasm_dep_analyzer"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
