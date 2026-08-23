# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="os_str_bytes"
CRATE_VERSION="7.2.0"
CRATE_CHECKSUM="89284d0c2af7b0eb5e814798aa07265413c8fd72009f7fc82ea25a81fb287ce9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lossless functionality for platform-native strings"
HOMEPAGE="https://github.com/dylni/os_str_bytes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"checked_conversions"
	"conversions"
	"default"
	"raw_os_str"
)
