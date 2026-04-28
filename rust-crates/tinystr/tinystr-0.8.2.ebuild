# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinystr"
CRATE_VERSION="0.8.2"
CRATE_CHECKSUM="42d3e9c45c09de15d06dd8acf5f4e0e399e85927b7f00711024eb7ae10fa4869"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small ASCII-only bounded length string representation."
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"serde"
	"std"
	"zerovec"
)
