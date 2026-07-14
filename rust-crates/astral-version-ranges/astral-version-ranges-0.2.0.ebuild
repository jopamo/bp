# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-version-ranges"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="086f936efdefab117f5a72367fb3d68c4fded8ba5a7008e3c63365eecf723822"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance-optimized type for generic version ranges and operations on them."
HOMEPAGE="https://github.com/astral-sh/pubgrub"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
