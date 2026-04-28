# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="darling"
CRATE_VERSION="0.21.3"
CRATE_CHECKSUM="9cdf337090841a411e2a7f3deb9187445851f91b309c0c0a29e05f74a00a48c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A proc-macro library for reading attributes into structs when implementing custom derives."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"diagnostics"
	"serde"
	"suggestions"
)
