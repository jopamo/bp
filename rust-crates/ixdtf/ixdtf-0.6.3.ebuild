# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ixdtf"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="33ef2d119044a672ceb96e59608dffe8677f29dc6ec48ed693a4b9ac84751e9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for Internet eXtended DateTime Format"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"duration"
)
