# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="junction"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="160f2eade097f30263b548aae5deb12ad349c909baa710fa24b92c9090b2e006"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="library for working with NTFS junctions"
HOMEPAGE="https://github.com/tesuji/junction"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"unstable_admin"
)
