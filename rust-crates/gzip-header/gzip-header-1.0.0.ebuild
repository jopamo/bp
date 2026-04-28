# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gzip-header"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="95cc527b92e6029a62960ad99aa8a6660faa4555fe5f731aab13aa6a921795a2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for decoding and encoding the header part of gzip files based on the gzip header implementation in the flate2 crate."
HOMEPAGE="https://github.com/oyvindln/gzip-header"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
