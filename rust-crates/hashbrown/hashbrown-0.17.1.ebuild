# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hashbrown"
CRATE_VERSION="0.17.1"
CRATE_CHECKSUM="ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust port of Google's SwissTable hash map"
HOMEPAGE="https://github.com/rust-lang/hashbrown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-hasher"
	"inline-more"
	"nightly"
	"raw-entry"
	"rustc-dep-of-std"
	"rustc-internal-api"
	"serde"
)
