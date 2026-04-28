# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bzip2"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="f3a53fac24f34a81bc9954b5d6cfce0c21e18ec6959f44f56e8e90e4bb7c346c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to libbzip2 for bzip2 compression and decompression exposed as Reader/Writer streams."
HOMEPAGE="https://github.com/trifectatechfoundation/bzip2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bzip2-sys"
	"default"
	"static"
)
