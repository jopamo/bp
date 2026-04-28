# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smallvec"
CRATE_VERSION="1.14.0"
CRATE_CHECKSUM="7fcf8323ef1faaee30a44a340193b1ac6814fd9b7b4e88e9d4519a3e4abe1cfd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="'Small vector' optimization: store up to a small number of items on the stack"
HOMEPAGE="https://github.com/servo/rust-smallvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"const_generics"
	"const_new"
	"debugger_visualizer"
	"drain_filter"
	"drain_keep_rest"
	"may_dangle"
	"specialization"
	"union"
	"write"
)
