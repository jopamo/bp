# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="csv"
CRATE_VERSION="1.4.0"
CRATE_CHECKSUM="52cd9d68cf7efc6ddfaaee42e7288d3a99d613d4b50f76ce9827ae0c6e14f938"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast CSV parsing with support for serde."
HOMEPAGE="https://github.com/BurntSushi/rust-csv"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
