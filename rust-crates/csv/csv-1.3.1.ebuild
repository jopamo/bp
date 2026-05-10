# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="csv"
CRATE_VERSION="1.3.1"
CRATE_CHECKSUM="acdc4883a9c96732e4733212c01447ebd805833b7275a73ca3ee080fd77afdaf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast CSV parsing with support for serde."
HOMEPAGE="https://github.com/BurntSushi/rust-csv"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
