# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="core-foundation"
CRATE_VERSION="0.9.4"
CRATE_CHECKSUM="91e195e091a93c46f7102ec7818a2aa394e1e1771c3ab4825963fa03e45afb8f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to Core Foundation for macOS"
HOMEPAGE="https://github.com/servo/core-foundation-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"link"
	"mac_os_10_7_support"
	"mac_os_10_8_features"
	"with-chrono"
	"with-uuid"
)
