# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="console"
CRATE_VERSION="0.16.2"
CRATE_CHECKSUM="03e45a4a8926227e4197636ba97a9fc9b00477e9f4bd711395687c5f0734bec4"
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
