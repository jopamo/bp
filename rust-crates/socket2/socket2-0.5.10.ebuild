# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="socket2"
CRATE_VERSION="0.5.10"
CRATE_CHECKSUM="e22376abed350d73dd1cd119b57ffccad95b4e585a7cda43e286245ce23c0678"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for handling networking sockets with a maximal amount of configuration possible intended."
HOMEPAGE="https://github.com/rust-lang/socket2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
)
