# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ciborium"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="42e69ffd6f0917f5c029256a24d0161db17cea3997d185db0d35926308770f0e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="serde implementation of CBOR using ciborium-basic"
HOMEPAGE="https://github.com/enarx/ciborium"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
