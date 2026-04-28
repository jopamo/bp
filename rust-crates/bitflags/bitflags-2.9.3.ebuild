# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bitflags"
CRATE_VERSION="2.9.3"
CRATE_CHECKSUM="34efbcccd345379ca2868b2b2c9d3782e9cc58ba87bc7d79d5b53d9c9ae6f25d"
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
	"std"
)
