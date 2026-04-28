# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling_core"
CRATE_VERSION="0.21.3"
CRATE_CHECKSUM="1247195ecd7e3c85f83c8d2a366e4210d588e802133e1e355180a9870b517ea4"
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
