# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cookie_store"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="3fc4bff745c9b4c7fb1e97b25d13153da2bc7796260141df62378998d070207f"
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
