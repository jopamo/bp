# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="resb"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="22d392791f3c6802a1905a509e9d1a6039cbbcb5e9e00e5a6d3661f7c874f390"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for reading and writing ICU resource bundle files"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"logging"
	"serialize"
	"std"
	"text"
)
