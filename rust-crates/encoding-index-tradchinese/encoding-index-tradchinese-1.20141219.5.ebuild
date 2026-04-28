# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding-index-tradchinese"
CRATE_VERSION="1.20141219.5"
CRATE_CHECKSUM="fd0e20d5688ce3cab59eb3ef3a2083a5c77bf496cb798dc6fcdb75f323890c18"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Index tables for traditional Chinese character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
