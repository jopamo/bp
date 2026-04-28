# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="io-uring"
CRATE_VERSION="0.7.8"
CRATE_CHECKSUM="b86e202f00093dcba4275d4636b93ef9dd75d025ae560d2521b45ea28ab49013"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The low-level `io_uring` userspace interface for Rust"
HOMEPAGE="https://github.com/tokio-rs/io-uring"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"direct-syscall"
	"io_safety"
	"overwrite"
)
