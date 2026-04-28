# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mustache"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="51956ef1c5d20a1384524d91e616fb44dfc7d8f249bf696d49c97dd3289ecab5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust implementation of Mustache"
HOMEPAGE="https://github.com/nickel-org/rust-mustache"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"unstable"
)
