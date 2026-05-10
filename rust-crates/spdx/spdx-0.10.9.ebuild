# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="spdx"
CRATE_VERSION="0.10.9"
CRATE_CHECKSUM="c3e17e880bafaeb362a7b751ec46bdc5b61445a188f80e0606e68167cd540fa3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper crate for SPDX expressions"
HOMEPAGE="https://github.com/EmbarkStudios/spdx"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"text"
)
