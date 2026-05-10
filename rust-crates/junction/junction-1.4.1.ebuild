# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="junction"
CRATE_VERSION="1.4.1"
CRATE_CHECKSUM="642883fdc81cf2da15ee8183fa1d2c7da452414dd41541a0f3e1428069345447"
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
