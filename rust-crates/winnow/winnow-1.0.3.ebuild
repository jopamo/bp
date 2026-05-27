# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="winnow"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="0592e1c9d151f854e6fd382574c3a0855250e1d9b2f99d9281c6e6391af352f1"
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
