# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="url"
CRATE_VERSION="2.5.7"
CRATE_CHECKSUM="08bc136a29a3d1758e07a9cca267be308aeebf5cfd5a10f3f67ab2097683ef5b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="URL library for Rust, based on the WHATWG URL Standard"
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"debugger_visualizer"
	"default"
	"expose_internals"
	"std"
)
