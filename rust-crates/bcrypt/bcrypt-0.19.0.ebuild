# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bcrypt"
CRATE_VERSION="0.19.0"
CRATE_CHECKSUM="523ab528ce3a7ada6597f8ccf5bd8d85ebe26d5edf311cad4d1d3cfb2d357ac6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easily hash and verify passwords using bcrypt"
HOMEPAGE="https://github.com/Keats/rust-bcrypt"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
