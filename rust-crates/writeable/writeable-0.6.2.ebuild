# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="writeable"
CRATE_VERSION="0.6.2"
CRATE_CHECKSUM="9edde0db4769d2dc68579893f2306b26c6ecfbe0ef499b013d731b7b9247e0b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A more efficient alternative to fmt::Display"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"either"
)
