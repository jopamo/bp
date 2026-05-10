# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="whoami"
CRATE_VERSION="2.0.2"
CRATE_CHECKSUM="ace4d5c7b5ab3d99629156d4e0997edbe98a4beb6d5ba99e2cae830207a81983"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust library for getting information about the current user and environment"
HOMEPAGE="https://github.com/ardaku/whoami/releases"
LICENSE="|| ( Apache-2.0 BSL-1.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"force-stub"
	"std"
	"wasi-wasite"
	"wasm-web"
)
