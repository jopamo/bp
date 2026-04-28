# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="path-dedot"
CRATE_VERSION="3.1.1"
CRATE_CHECKSUM="07ba0ad7e047712414213ff67533e6dd477af0a4e1d14fb52343e53d30ea9397"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for extending `Path` and `PathBuf` in order to parse the path which contains dots."
HOMEPAGE="https://magiclen.org/path-dedot"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"lazy_static_cache"
	"once_cell_cache"
	"unsafe_cache"
	"use_unix_paths_on_wasm"
)
