# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling"
CRATE_VERSION="0.20.10"
CRATE_CHECKSUM="6f63b86c8a8826a49b8c21f08a2d07338eec8d900540f8630dc76284be802989"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A proc-macro library for reading attributes into structs when implementing custom derives."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"diagnostics"
	"suggestions"
)
