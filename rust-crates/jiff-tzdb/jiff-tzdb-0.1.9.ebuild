# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-tzdb"
CRATE_VERSION="0.1.9"
CRATE_CHECKSUM="fa8377070c6bae868759445e5a77f66d84f0b72f3a054bfb00e6d038b8282da7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The entire Time Zone Database embedded into your binary."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-tzdb"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
