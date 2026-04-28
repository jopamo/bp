# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winreg"
CRATE_VERSION="0.52.0"
CRATE_CHECKSUM="a277a57398d4bfa075df44f501a17cfdf8542d224f0d36095a2adc7aee4ef0a5"
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
