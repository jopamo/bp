# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="generic-array"
CRATE_VERSION="0.14.7"
CRATE_CHECKSUM="85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic types implementing functionality of arrays"
HOMEPAGE="https://github.com/fizyk20/generic-array.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"more_lengths"
)
