# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bitflags"
CRATE_VERSION="2.9.4"
CRATE_CHECKSUM="2261d10cca569e4643e526d8dc2e62e433cc8aba21ab764233731f8d369bf394"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro to generate structures which behave like bitflags."
HOMEPAGE="https://github.com/bitflags/bitflags"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"example_generated"
	"std"
)
