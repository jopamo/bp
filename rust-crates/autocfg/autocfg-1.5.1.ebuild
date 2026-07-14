# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="autocfg"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="f2032f911046de80f0a198e0901378627c33f59ea0ac00e363d481118bd70a53"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatic cfg for Rust compiler features"
HOMEPAGE="https://github.com/cuviper/autocfg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
