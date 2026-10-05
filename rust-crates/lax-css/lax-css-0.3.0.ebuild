# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lax-css"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="c964e0b1c58e6a38762c707d7b5f7a78ab4efab65d3e6c4ab2031deb8f65229e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lax CSS, SCSS, and Less formatter that never reinterprets your code. Usable as a library or a dprint plugin."
HOMEPAGE="https://github.com/bartlomieju/lax"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"wasm"
)
