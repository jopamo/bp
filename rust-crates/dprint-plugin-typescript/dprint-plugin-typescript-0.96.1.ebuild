# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dprint-plugin-typescript"
CRATE_VERSION="0.96.1"
CRATE_CHECKSUM="90733c56ab425fc299c25ad81a5924bfc3c0050f25d865da742a6987b1255927"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="TypeScript and JavaScript code formatter."
HOMEPAGE="https://github.com/dprint/dprint-plugin-typescript"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"tracing"
	"wasm"
)
