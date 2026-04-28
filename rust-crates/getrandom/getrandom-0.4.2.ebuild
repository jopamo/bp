# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="getrandom"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="0de51e6874e94e7bf76d726fc5d13ba782deca734ff60d5bb2fb2607c7406555"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small cross-platform library for retrieving random data from system source"
HOMEPAGE="https://github.com/rust-random/getrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
	"sys_rng"
	"wasm_js"
)
