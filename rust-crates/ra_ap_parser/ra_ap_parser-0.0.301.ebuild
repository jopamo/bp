# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_parser"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="3a3b92b8b147c0826b83e70ad44e3c98e94201fc93e1f09396c43b4d7958c22a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The Rust parser for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
)
