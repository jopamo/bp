# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zoneinfo64"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="ed6eb2607e906160c457fd573e9297e65029669906b9ac8fb1b5cd5e055f0705"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Working with ICU zoneinfo64.res timezone data bundles"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"chrono"
)
