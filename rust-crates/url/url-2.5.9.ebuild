# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="url"
CRATE_VERSION="2.5.9"
CRATE_CHECKSUM="f00cd2407bb42c0ef17be88d4cf020f5cceffd121665bac9b8b9493a369b3b1a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="URL library for Rust, based on the WHATWG URL Standard"
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debugger_visualizer"
	"default"
	"expose_internals"
	"serde"
	"std"
)
