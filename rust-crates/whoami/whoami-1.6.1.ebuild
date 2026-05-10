# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="whoami"
CRATE_VERSION="1.6.1"
CRATE_CHECKSUM="5d4a4db5077702ca3015d3d02d74974948aba2ad9e12ab7df718ee64ccd7e97d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Retrieve the current user and environment."
HOMEPAGE="https://github.com/ardaku/whoami/blob/v1/CHANGELOG.md"
LICENSE="|| ( Apache-2.0 BSL-1.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"web"
)
