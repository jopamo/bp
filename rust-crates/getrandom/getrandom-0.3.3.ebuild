# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="getrandom"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="26145e563e54f2cadc477553f1ec5ee650b00862f0a58bcd12cbdc5f0ea2d2f4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small cross-platform library for retrieving random data from system source"
HOMEPAGE="https://github.com/rust-random/getrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
	"std"
	"wasm_js"
)
