# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="supports-unicode"
CRATE_VERSION="3.0.0"
CRATE_CHECKSUM="b7401a30af6cb5818bb64852270bb722533397edcfc7344954a38f420819ece2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detects whether a terminal supports unicode."
HOMEPAGE="https://github.com/zkat/supports-unicode"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
