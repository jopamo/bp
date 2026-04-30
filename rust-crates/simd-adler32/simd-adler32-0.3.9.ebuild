# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="simd-adler32"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="703d5c7ef118737c72f1af64ad2f6f8c5e1921f818cdcb97b8fe6fc69bf66214"
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
