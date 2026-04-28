# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winreg"
CRATE_VERSION="0.55.0"
CRATE_CHECKSUM="cb5a765337c50e9ec252c2069be9bf91c7df47afb103b642ba3a53bf8101be97"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to MS Windows Registry API"
HOMEPAGE="https://github.com/gentoo90/winreg-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serialization-serde"
	"transactions"
)
