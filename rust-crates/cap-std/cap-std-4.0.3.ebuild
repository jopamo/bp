# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cap-std"
CRATE_VERSION="4.0.3"
CRATE_CHECKSUM="c1ec78e242cfa2cfe276807ac2ecc00315a6c97786977414bcd1c3963b6c91b8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Capability-based version of the Rust standard library"
HOMEPAGE="https://github.com/bytecodealliance/cap-std"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arf_strings"
	"default"
	"fs_utf8"
)
