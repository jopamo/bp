# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libsqlite3-sys"
CRATE_VERSION="0.32.0"
CRATE_CHECKSUM="fbb8270bb4060bd76c6e96f20c52d80620f1d82a3470885694e41e0f81ef6fe7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Native bindings to the libsqlite3 library"
HOMEPAGE="https://github.com/rusqlite/rusqlite"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"buildtime_bindgen"
	"bundled"
	"bundled-sqlcipher"
	"bundled-sqlcipher-vendored-openssl"
	"bundled-windows"
	"bundled_bindings"
	"default"
	"in_gecko"
	"loadable_extension"
	"min_sqlite_version_3_14_0"
	"preupdate_hook"
	"session"
	"sqlcipher"
	"unlock_notify"
	"wasm32-wasi-vfs"
	"with-asan"
)
