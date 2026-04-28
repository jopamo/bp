# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding-index-japanese"
CRATE_VERSION="1.20141219.5"
CRATE_CHECKSUM="04e8b2ff42e9a05335dbf8b5c6f7567e5591d0d916ccef4e0b1710d32a0d0c91"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Index tables for Japanese character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
