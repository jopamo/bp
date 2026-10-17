# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="normpath"
CRATE_VERSION="1.5.2"
CRATE_CHECKSUM="b11ce00d2594068e8a27c9146fdc5cf9f3ac38eb42c7cd34d05fea618873ac9f"
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
