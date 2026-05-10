# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-util"
CRATE_VERSION="0.2.23"
CRATE_CHECKSUM="5fbac95faac578313b0ba60f9a5594a97cae42692f23b133ecd17615dedca50e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Miscellaneous support code used by Cargo."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
