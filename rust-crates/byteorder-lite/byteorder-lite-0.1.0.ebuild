# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="byteorder-lite"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="8f1fe948ff07f4bd06c30984e69f5b4899c516a3ef74f34df92a2df2ab535495"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for reading/writing numbers in big-endian and little-endian."
HOMEPAGE="https://github.com/image-rs/byteorder-lite"
LICENSE="|| ( Unlicense MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
