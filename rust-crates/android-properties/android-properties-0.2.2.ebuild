# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="android-properties"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="fc7eb209b1518d6bb87b283c20095f5228ecda460da70b44f0802523dea6da04"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust-based Android properties wrapper"
HOMEPAGE="https://github.com/miklelappo/android-properties"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bionic-deprecated"
)
