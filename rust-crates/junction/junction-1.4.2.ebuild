# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="junction"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="8cfc352a66ba903c23239ef51e809508b6fc2b0f90e3476ac7a9ff47e863ae95"
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
