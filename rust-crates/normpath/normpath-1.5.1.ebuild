# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="normpath"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="b9985ef7269fa99f3b12437bb698381da2428743ab90f20393f399fa14cab21a"
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
