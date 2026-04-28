# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling_core"
CRATE_VERSION="0.20.10"
CRATE_CHECKSUM="95133861a8032aaea082871032f5815eb9e98cef03fa916ab4500513994df9e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"diagnostics"
	"suggestions"
)
