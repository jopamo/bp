# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-tzdb"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="142bd39932ad231f10513df9ab62661fead8719872150b7ad02a2df79f4e141e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The entire Time Zone Database embedded into your binary."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-tzdb"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
