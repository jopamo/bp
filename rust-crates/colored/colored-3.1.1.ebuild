# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="colored"
CRATE_VERSION="3.1.1"
CRATE_CHECKSUM="faf9468729b8cbcea668e36183cb69d317348c2e08e994829fb56ebfdfbaac34"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The most simple way to add colors in your terminal"
HOMEPAGE="https://github.com/mackwic/colored"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no-color"
)
