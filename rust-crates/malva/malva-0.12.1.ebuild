# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="malva"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="aa8f6005fe3f2348f1fc59d647ee6945d5832fd080178e6d034bab1bf7976348"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Configurable, smart and fast CSS, SCSS, Sass and Less formatter."
HOMEPAGE="https://github.com/g-plane/malva"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"config_serde"
)
