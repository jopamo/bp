# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rpm-version"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="56568fb1bf1d2c0a640aac216b3d84d65e210ca1997df922bf124f2bfaf9efd9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for dealing with RPM versions (NEVRA, EVR) correctly. Sort algorithm is identical to RPM."
HOMEPAGE="https://crates.io/crates/rpm-version"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"python"
	"serde"
)
