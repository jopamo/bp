# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winreg"
CRATE_VERSION="0.50.0"
CRATE_CHECKSUM="524e57b2c537c0f9b1e69f1965311ec12182b4122e45035b1508cd24d2adadb1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to MS Windows Registry API"
HOMEPAGE="https://github.com/gentoo90/winreg-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"serialization-serde"
	"transactions"
)
