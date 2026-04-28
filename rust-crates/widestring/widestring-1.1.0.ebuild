# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="widestring"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="7219d36b6eac893fa81e84ebe06485e7dcbb616177469b142df14f1f4deb1311"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A wide string Rust library for converting to and from wide strings, such as those often used in Windows API or other FFI libaries. Both `u16` and `u32` string types are provided, including support for UTF-16 and UTF-32, malformed encoding, C-style strings, etc."
HOMEPAGE="https://github.com/starkat99/widestring-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debugger_visualizer"
	"default"
	"std"
)
