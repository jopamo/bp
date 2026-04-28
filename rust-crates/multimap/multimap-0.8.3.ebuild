# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="multimap"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="e5ce46fe64a9d73be07dcbe690a38ce1b293be448fd8ce1e6c1b8062c9f72c6a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A multimap implementation."
HOMEPAGE="https://github.com/havarnov/multimap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde_impl"
)
