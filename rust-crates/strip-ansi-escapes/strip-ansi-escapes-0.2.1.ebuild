# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="strip-ansi-escapes"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="2a8f8038e7e7969abb3f1b7c2a811225e9296da208539e0f79c5251d6cac0025"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Strip ANSI escape sequences from byte streams."
HOMEPAGE="https://github.com/luser/strip-ansi-escapes"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
