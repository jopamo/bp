# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cesu8"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="6d43a04d8753f35258c91f8ec639f792891f748a1edbd759cf1dcea3382ad83c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convert to and from CESU-8 encoding (similar to UTF-8)"
HOMEPAGE="https://github.com/emk/cesu8-rs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unstable"
)
