# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quote"
CRATE_VERSION="1.0.40"
CRATE_CHECKSUM="1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quasi-quoting macro quote!(...)"
HOMEPAGE="https://github.com/dtolnay/quote"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
