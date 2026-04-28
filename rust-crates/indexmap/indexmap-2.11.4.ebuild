# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indexmap"
CRATE_VERSION="2.11.4"
CRATE_CHECKSUM="4b0f83760fb341a774ed326568e19f5a863af4a952def8c39f9ab92fd95b88e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A hash table with consistent order and fast iteration."
HOMEPAGE="https://github.com/indexmap-rs/indexmap"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
	"test_debug"
)
