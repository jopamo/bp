# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="win32job"
CRATE_VERSION="2.0.3"
CRATE_CHECKSUM="8c6a6724ccfbf34154a8691bd868b0fcd2be2ca3f7b47b32614654f1a01b191c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A safe API for Windows' job objects."
HOMEPAGE="https://github.com/ohadravid/win32job-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
