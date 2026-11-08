# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="speedate"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="da8f8c5f7f7ea2811a17f99bca4fec7f9ef0b0734713a5cbfc9baee203eba8eb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast and simple datetime, date, time and duration parsing"
HOMEPAGE="https://github.com/pydantic/speedate/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
