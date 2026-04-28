# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff-tzdb-platform"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="875a5a69ac2bab1a891711cf5eccbec1ce0341ea805560dcd90b7a2e925132e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The entire Time Zone Database embedded into your binary for specific platforms."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-tzdb-platform"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
