# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding-index-singlebyte"
CRATE_VERSION="1.20141219.5"
CRATE_CHECKSUM="3351d5acffb224af9ca265f435b859c7c01537c0849754d3db3fdf2bfe2ae84a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Index tables for various single-byte character encodings"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="CC0-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
