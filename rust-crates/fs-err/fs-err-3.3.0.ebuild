# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fs-err"
CRATE_VERSION="3.3.0"
CRATE_CHECKSUM="73fde052dbfc920003cfd2c8e2c6e6d4cc7c1091538c3a24226cec0665ab08c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A drop-in replacement for std::fs with more helpful error messages."
HOMEPAGE="https://github.com/andrewhickman/fs-err"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"debug_tokio"
	"expose_original_error"
)
