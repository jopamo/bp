# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="simdutf8"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="e3a9fe34e3e7a50316060351f37187a3f546bce95496156754b601a5fa71b76e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SIMD-accelerated UTF-8 validation."
HOMEPAGE="https://github.com/rusticstuff/simdutf8"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aarch64_neon"
	"aarch64_neon_prefetch"
	"default"
	"hints"
	"public_imp"
	"std"
)
