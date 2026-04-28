# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winnow"
CRATE_VERSION="0.7.14"
CRATE_CHECKSUM="5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
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
	"debug"
	"default"
	"simd"
	"std"
	"unstable-doc"
	"unstable-recover"
)
