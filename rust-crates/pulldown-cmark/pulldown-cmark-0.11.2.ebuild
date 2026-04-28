# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pulldown-cmark"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="cb4e75767fbc9d92b90e4d0c011f61358cde9513b31ef07ea3631b15ffc3b4fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pull parser for CommonMark"
HOMEPAGE="https://github.com/raphlinus/pulldown-cmark"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"gen-tests"
	"html"
	"simd"
)
