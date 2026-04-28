# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="url"
CRATE_VERSION="2.5.4"
CRATE_CHECKSUM="32f8b686cadd1473f4bd0117a5d28d36b1ade384ea9b5069a1c40aefed7fda60"
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
	"std"
)
