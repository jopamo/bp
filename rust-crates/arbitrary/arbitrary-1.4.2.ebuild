# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="arbitrary"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="c3d036a3c4ab069c7b410a2ce876bd74808d2d0888a82667669f8e783a898bf1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The trait for generating structured data from unstructured data"
HOMEPAGE="https://github.com/rust-fuzz/arbitrary/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"derive"
)
