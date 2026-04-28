# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base64-simd"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="339abbe78e73178762e23bea9dfd08e697eb3f3301cd4be981c0f78ba5859195"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SIMD-accelerated base64 encoding and decoding"
HOMEPAGE="https://github.com/Nugine/simd"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"detect"
	"std"
	"unstable"
)
