# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="diplomat-runtime"
CRATE_VERSION="0.15.1"
CRATE_CHECKSUM="970ac38ad677632efcee6d517e783958da9bc78ec206d8d5e35b459ffc5e4864"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common runtime utilities used by diplomat codegen"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"jvm-callback-support"
	"log"
)
