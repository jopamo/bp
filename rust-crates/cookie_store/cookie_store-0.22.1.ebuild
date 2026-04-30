# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cookie_store"
CRATE_VERSION="0.22.1"
CRATE_CHECKSUM="15b2c103cf610ec6cae3da84a766285b42fd16aad564758459e6ecf128c75206"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of Cookie storage and retrieval"
HOMEPAGE="https://github.com/pfernie/cookie_store"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"log_secure_cookie_values"
	"preserve_order"
	"public_suffix"
	"serde"
	"serde_json"
	"serde_ron"
	"wasm-bindgen"
)
