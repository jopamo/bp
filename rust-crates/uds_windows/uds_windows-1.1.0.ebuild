# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="uds_windows"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="89daebc3e6fd160ac4aa9fc8b3bf71e1f74fbf92367ae71fb83a037e8bf164b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unix Domain Sockets for Windows!"
HOMEPAGE="https://github.com/haraldh/rust_uds_windows"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
