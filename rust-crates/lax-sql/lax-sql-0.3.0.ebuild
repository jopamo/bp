# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="lax-sql"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="e2cca919c19f0e32e8a9fe410e087fc71e4a5ce7a843f939967c643e7881981f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lax SQL formatter that never reinterprets your code. Dialect agnostic by construction. Usable as a library or a dprint plugin."
HOMEPAGE="https://github.com/bartlomieju/lax"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"wasm"
)
