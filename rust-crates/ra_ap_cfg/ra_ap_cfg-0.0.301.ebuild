# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_cfg"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="3a0b56eb4536ce6d2431932c4d337aeeaf7bb22c9249b38cbe80677b5881228f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compiling options, \`cfg\` attribute parser and evaluator for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
