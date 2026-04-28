# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff-tzdb"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="c900ef84826f1338a557697dc8fc601df9ca9af4ac137c7fb61d4c6f2dfd3076"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The entire Time Zone Database embedded into your binary."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-tzdb"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
