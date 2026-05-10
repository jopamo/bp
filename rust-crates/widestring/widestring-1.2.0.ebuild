# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="widestring"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="dd7cf3379ca1aac9eea11fba24fd7e315d621f8dfe35c8d7d2be8b793726e07d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A wide string Rust library for converting to and from wide strings, such as those often used in Windows API or other FFI libaries. Both \`u16\` and \`u32\` string types are provided, including support for UTF-16 and UTF-32, malformed encoding, C-style strings, etc."
HOMEPAGE="https://github.com/starkat99/widestring-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"debugger_visualizer"
	"default"
	"std"
)
