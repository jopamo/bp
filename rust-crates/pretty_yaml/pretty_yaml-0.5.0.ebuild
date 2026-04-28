# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pretty_yaml"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="dda9a64ee7296e82d1e0f4389383e6a7d8e6e2487d8391f7d028c131395fd376"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semi-tolerant and configurable YAML formatter."
HOMEPAGE="https://github.com/g-plane/pretty_yaml"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"config_serde"
)
