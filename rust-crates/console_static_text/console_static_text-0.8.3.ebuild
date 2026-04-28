# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="console_static_text"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="55d8a913e62f6444b79e038be3eb09839e9cfc34d55d85f9336460710647d2f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Logging for text that should stay in the same place in a console."
HOMEPAGE="https://github.com/dsherret/console_static_text"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"sized"
)
