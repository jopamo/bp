# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tempfile"
CRATE_VERSION="3.27.0"
CRATE_CHECKSUM="32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for managing temporary files and directories."
HOMEPAGE="https://stebalien.com/projects/tempfile-rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
