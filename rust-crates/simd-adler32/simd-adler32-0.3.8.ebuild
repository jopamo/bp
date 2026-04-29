# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="simd-adler32"
CRATE_VERSION="0.3.8"
CRATE_CHECKSUM="e320a6c5ad31d271ad523dcf3ad13e2767ad8b1cb8f047f75a8aeaf8da139da2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A SIMD-accelerated Adler-32 hash algorithm implementation."
HOMEPAGE="https://github.com/mcountryman/simd-adler32"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"default"
	"nightly"
	"std"
)
