# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="io-uring"
CRATE_VERSION="0.7.9"
CRATE_CHECKSUM="d93587f37623a1a17d94ef2bc9ada592f5465fe7732084ab7beefabe5c77c0c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The low-level \`io_uring\` userspace interface for Rust"
HOMEPAGE="https://github.com/tokio-rs/io-uring"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"direct-syscall"
	"io_safety"
	"overwrite"
)
