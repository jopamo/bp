# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="whoami"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="d6a5b12f9df4f978d2cfdb1bd3bac52433f44393342d7ee9c25f5a1c14c0f45d"
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
