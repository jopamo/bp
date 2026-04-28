# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strict-num"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="6637bab7722d379c8b41ba849228d680cc12d0a45ba1fa2b48f2a30577a06731"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of bounded numeric types"
HOMEPAGE="https://github.com/RazrFalcon/strict-num"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"approx-eq"
	"default"
)
