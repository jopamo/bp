# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="terminal_size"
CRATE_VERSION="0.4.4"
CRATE_CHECKSUM="230a1b821ccbd75b185820a1f1ff7b14d21da1e442e22c0863ea5f08771a8874"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Gets the size of your Linux or Windows terminal"
HOMEPAGE="https://github.com/eminence/terminal-size"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
