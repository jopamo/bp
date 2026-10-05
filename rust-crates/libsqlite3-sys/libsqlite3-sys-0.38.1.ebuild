# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libsqlite3-sys"
CRATE_VERSION="0.38.1"
CRATE_CHECKSUM="f6c19a05435c21ac299d71b6a9c13db3e3f47c520517d58990a462a1397a61db"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Native bindings to the libsqlite3 library"
HOMEPAGE="https://github.com/rusqlite/rusqlite"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"buildtime_bindgen"
	"bundled"
	"bundled-sqlcipher"
	"bundled-sqlcipher-vendored-openssl"
	"bundled-windows"
	"bundled_bindings"
	"column_metadata"
	"default"
	"in_gecko"
	"loadable_extension"
	"min_sqlite_version_3_34_1"
	"preupdate_hook"
	"session"
	"sqlcipher"
	"unlock_notify"
	"wasm32-wasi-vfs"
	"with-asan"
)
