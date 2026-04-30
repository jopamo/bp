# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="memo-map"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="38d1115007560874e373613744c6fba374c17688327a71c1476d1a5954cc857b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate implementing a synchronized map for memoization"
HOMEPAGE="https://github.com/mitsuhiko/memo-map"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
