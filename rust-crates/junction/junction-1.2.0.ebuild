# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="junction"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="72bbdfd737a243da3dfc1f99ee8d6e166480f17ab4ac84d7c34aacd73fc7bd16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="library for working with NTFS junctions"
HOMEPAGE="https://github.com/tesuji/junction"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"unstable_admin"
)
