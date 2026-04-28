# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="signal-hook-mio"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="34db1a06d485c9142248b7a054f034b349b212551f3dfd19c94d45a754a217cd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="MIO support for signal-hook"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"support-v0_6"
	"support-v0_7"
	"support-v0_8"
	"support-v1_0"
)
