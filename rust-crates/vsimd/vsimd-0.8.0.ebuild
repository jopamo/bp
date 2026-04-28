# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vsimd"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="5c3082ca00d5a5ef149bb8b555a72ae84c9c59f7250f013ac822ac2e49b19c64"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SIMD utilities"
HOMEPAGE="https://github.com/Nugine/simd"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"detect"
	"std"
	"unstable"
)
