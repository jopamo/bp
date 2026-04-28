# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="blake2"
CRATE_VERSION="0.10.6"
CRATE_CHECKSUM="46502ad458c9a52b69d4d4d32775c788b7a1b85e8bc9d482d92250fc0e3f8efe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="BLAKE2 hash functions"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"reset"
	"simd"
	"simd_asm"
	"simd_opt"
	"size_opt"
	"std"
)
