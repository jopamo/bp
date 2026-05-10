# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="http"
CRATE_VERSION="1.3.1"
CRATE_CHECKSUM="f4a85d31aea989eead29a3aaf9e1115a180df8282431156e533de47660892565"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A set of types for representing HTTP requests and responses."
HOMEPAGE="https://github.com/hyperium/http"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
