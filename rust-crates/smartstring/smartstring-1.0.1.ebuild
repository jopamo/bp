# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smartstring"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="3fb72c633efbaa2dd666986505016c32c3044395ceaf881518399d2f4127ee29"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compact inlined strings"
HOMEPAGE="https://github.com/bodil/smartstring"
LICENSE="MPL-2.0+"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"test"
)
