# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zerocopy-derive"
CRATE_VERSION="0.8.26"
CRATE_CHECKSUM="9ecf5b4cc5364572d7f4c329661bcc82724222973f2cab6f050a4e5c22f75181"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for traits from the zerocopy crate"
HOMEPAGE="https://github.com/google/zerocopy"
LICENSE="|| ( BSD-2-Clause Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
