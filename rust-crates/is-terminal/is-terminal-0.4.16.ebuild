# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="is-terminal"
CRATE_VERSION="0.4.16"
CRATE_CHECKSUM="e04d7f318608d35d4b61ddd75cbdaee86b023ebe2bd5a66ee0915f0bf93095a9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test whether a given stream is a terminal"
HOMEPAGE="https://github.com/sunfishcode/is-terminal"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
