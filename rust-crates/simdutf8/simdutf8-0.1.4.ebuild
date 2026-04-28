# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="simdutf8"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="f27f6278552951f1f2b8cf9da965d10969b2efdea95a6ec47987ab46edfe263a"
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
