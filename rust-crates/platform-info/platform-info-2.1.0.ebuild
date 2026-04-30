# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="platform-info"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="9368d62437c8cbb7c31ee37fd8c08a7d390e09a3ff75698a674953f46705ffcb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple cross-platform interface to get info about a system"
HOMEPAGE="https://github.com/uutils/platform-info"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
