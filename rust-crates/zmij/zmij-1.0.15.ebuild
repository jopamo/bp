# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zmij"
CRATE_VERSION="1.0.15"
CRATE_CHECKSUM="94f63c051f4fe3c1509da62131a678643c5b6fbdc9273b2b79d4378ebda003d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A double-to-string conversion algorithm based on Schubfach and yy"
HOMEPAGE="https://github.com/dtolnay/zmij"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
