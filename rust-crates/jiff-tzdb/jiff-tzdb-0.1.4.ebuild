# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff-tzdb"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="c1283705eb0a21404d2bfd6eef2a7593d240bc42a0bdb39db0ad6fa2ec026524"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The entire Time Zone Database embedded into your binary."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-tzdb"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
