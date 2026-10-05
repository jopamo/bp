# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sqlite-wasm-rs"
CRATE_VERSION="0.5.5"
CRATE_CHECKSUM="dc3efc0da82635d7e1ced0053bbbfa8c7ab9645d0bf36ceb4f7127bb85315d75"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`wasm32-unknown-unknown\` bindings to the libsqlite3 library."
HOMEPAGE="https://github.com/Spxg/sqlite-wasm-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"sqlite3mc"
)
