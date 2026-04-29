# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="safe-transmute"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="3944826ff8fa8093089aba3acb4ef44b9446a99a16f3bf4e74af3f77d340ab7d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A safeguarded transmute() for Rust"
HOMEPAGE="https://github.com/nabijaczleweli/safe-transmute-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"const_generics"
	"default"
	"std"
)
