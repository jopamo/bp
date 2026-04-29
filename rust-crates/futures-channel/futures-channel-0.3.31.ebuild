# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures-channel"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="2dff15bf788c671c1934e366d07e30c1814a8ef514e1af724a602e8a2fbe1b10"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Channels for asynchronous communication using futures-rs."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"cfg-target-has-atomic"
	"default"
	"sink"
	"std"
	"unstable"
)
