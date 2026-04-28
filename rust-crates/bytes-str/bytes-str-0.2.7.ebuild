# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytes-str"
CRATE_VERSION="0.2.7"
CRATE_CHECKSUM="7c60b5ce37e0b883c37eb89f79a1e26fbe9c1081945d024eee93e8d91a7e18b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A string type that is backed by bytes crate"
HOMEPAGE="https://github.com/dudykr/ddbase.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"rkyv"
	"serde"
)
