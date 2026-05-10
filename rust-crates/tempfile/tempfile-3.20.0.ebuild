# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tempfile"
CRATE_VERSION="3.20.0"
CRATE_CHECKSUM="e8a64e3985349f2441a1a9ef0b853f869006c3855f2cda6862a94d26ebb9d6a1"
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
	"unstable-windows-keep-open-tempfile"
)
