# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="heck"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="95505c38b4572b2d910cecb0281560f54b440a19336cbbcb27bf6ce6adc6f5a8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="heck is a case conversion library."
HOMEPAGE="https://github.com/withoutboats/heck"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unicode"
)
