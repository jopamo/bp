# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="io-uring"
CRATE_VERSION="0.7.10"
CRATE_CHECKSUM="046fa2d4d00aea763528b4950358d0ead425372445dc8ff86312b3c69ff7727b"
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
