# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="console"
CRATE_VERSION="0.16.6"
CRATE_CHECKSUM="e96a4956774c13c126a8b5af4daa79384f4d826534c95a02d76afb39e2ab64e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A terminal and console abstraction for Rust"
HOMEPAGE="https://github.com/console-rs/console"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"ansi-parsing"
	"default"
	"std"
	"windows-console-colors"
)
