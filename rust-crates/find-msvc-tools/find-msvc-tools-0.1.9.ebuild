# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="find-msvc-tools"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find windows-specific tools, read MSVC versions from the registry and from COM interfaces"
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
