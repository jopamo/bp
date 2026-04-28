# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinystr"
CRATE_VERSION="0.7.6"
CRATE_CHECKSUM="9117f5d4db391c1cf6927e7bea3db74b9a1c1add8f7eda9ffd5364f40f57b82f"
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
	"bench"
	"default"
	"std"
)
