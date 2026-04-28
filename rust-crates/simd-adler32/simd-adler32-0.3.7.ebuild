# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="simd-adler32"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="d66dc143e6b11c1eddc06d5c423cfc97062865baf299914ab64caa38182078fe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A SIMD-accelerated Adler-32 hash algorithm implementation."
HOMEPAGE="https://github.com/mcountryman/simd-adler32"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"default"
	"nightly"
	"std"
)
