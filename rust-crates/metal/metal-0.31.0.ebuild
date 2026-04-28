# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="metal"
CRATE_VERSION="0.31.0"
CRATE_CHECKSUM="f569fb946490b5743ad69813cb19629130ce9374034abe31614a36402d18f99e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for Metal"
HOMEPAGE="https://github.com/gfx-rs/metal-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cargo-clippy"
	"default"
	"link"
	"mps"
	"private"
)
