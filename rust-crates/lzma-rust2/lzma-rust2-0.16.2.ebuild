# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lzma-rust2"
CRATE_VERSION="0.16.2"
CRATE_CHECKSUM="47bb1e988e6fb779cf720ad431242d3f03167c1b3f2b1aae7f1a94b2495b36ae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="LZMA / LZMA2 / LZIP / XZ compression ported from 'tukaani xz for java'"
HOMEPAGE="https://github.com/hasenbanck/lzma-rust2/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"encoder"
	"lzip"
	"optimization"
	"std"
	"xz"
)
