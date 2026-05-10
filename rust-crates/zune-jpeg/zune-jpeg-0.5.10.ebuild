# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zune-jpeg"
CRATE_VERSION="0.5.10"
CRATE_CHECKSUM="ea2db9186c0a6ad1aa7012046f3fadc8db9001691b367c510f5867f17f975752"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast, correct and safe jpeg decoder"
HOMEPAGE="https://github.com/etemesi254/zune-image/tree/dev/crates/zune-jpeg"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"log"
	"neon"
	"portable_simd"
	"std"
	"x86"
)
