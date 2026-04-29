# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="walkdir"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Recursively walk a directory."
HOMEPAGE="https://github.com/BurntSushi/walkdir"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
