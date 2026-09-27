# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="console"
CRATE_VERSION="0.16.4"
CRATE_CHECKSUM="4fe5f465a4f6fee88fad41b85d990f84c835335e85b5d9e6e63e0d06d28cba7c"
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
