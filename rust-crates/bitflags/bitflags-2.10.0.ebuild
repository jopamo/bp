# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bitflags"
CRATE_VERSION="2.10.0"
CRATE_CHECKSUM="812e12b5285cc515a9c72a5c1d3b6d46a19dac5acfef5265968c166106e31dd3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to generate structures which behave like bitflags."
HOMEPAGE="https://github.com/bitflags/bitflags"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"example_generated"
	"serde"
	"std"
)
