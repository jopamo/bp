# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="winnow"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="09dac053f1cd375980747450bfc7250c264eaae0583872e845c0c7cd578872b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A byte-oriented, zero-copy, parser combinators library"
HOMEPAGE="https://github.com/winnow-rs/winnow"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"ascii"
	"binary"
	"debug"
	"default"
	"parser"
	"simd"
	"std"
	"unstable-doc"
	"unstable-recover"
)
