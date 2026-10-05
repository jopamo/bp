# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="qbsdiff"
CRATE_VERSION="1.4.4"
CRATE_CHECKSUM="fdc7f24528be166f08f2c7becaca5618865499b6ded2565d5afcd795cc0d7596"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast and memory saving bsdiff 4.x compatible delta compressor and patcher."
HOMEPAGE="https://github.com/hucsmn/qbsdiff"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cmd"
	"default"
)
