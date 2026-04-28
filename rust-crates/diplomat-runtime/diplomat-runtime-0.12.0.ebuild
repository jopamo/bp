# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="diplomat-runtime"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="098f9520ec5c190943b083bca3ea4cc4e67dc5f85a37062e528ecf1d25f04eb4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common runtime utilities used by diplomat codegen"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"jvm-callback-support"
	"log"
)
