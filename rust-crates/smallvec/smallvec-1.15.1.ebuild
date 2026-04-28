# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smallvec"
CRATE_VERSION="1.15.1"
CRATE_CHECKSUM="67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="'Small vector' optimization: store up to a small number of items on the stack"
HOMEPAGE="https://github.com/servo/rust-smallvec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const_generics"
	"const_new"
	"debugger_visualizer"
	"drain_filter"
	"drain_keep_rest"
	"impl_bincode"
	"may_dangle"
	"specialization"
	"union"
	"write"
)
