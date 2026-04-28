# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerovec"
CRATE_VERSION="0.10.4"
CRATE_CHECKSUM="aa2b893d79df23bfb12d5461018d408ea19dfafe76c2c7ef6d4eba614f8ff079"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy vector backed by a byte array"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"databake"
	"derive"
	"hashmap"
	"serde"
	"std"
	"yoke"
)
