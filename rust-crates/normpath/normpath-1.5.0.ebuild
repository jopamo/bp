# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="normpath"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="bf23ab2b905654b4cb177e30b629937b3868311d4e1cba859f899c041046e69b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="More reliable path manipulation"
HOMEPAGE="https://github.com/dylni/normpath"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"localization"
)
