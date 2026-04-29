# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="console"
CRATE_VERSION="0.16.1"
CRATE_CHECKSUM="b430743a6eb14e9764d4260d4c0d8123087d504eeb9c48f2b2a5e810dd369df4"
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
