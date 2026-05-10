# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="terminal_size"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="45c6481c4829e4cc63825e62c49186a34538b7b2750b73b266581ffb612fb5ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Gets the size of your Linux or Windows terminal"
HOMEPAGE="https://github.com/eminence/terminal-size"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
