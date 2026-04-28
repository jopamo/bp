# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="number_prefix"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="830b246a0e5f20af87141b25c173cd1b609bd7779a4617d6ec582abaf90870f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for numeric prefixes (kilo, giga, kibi)."
HOMEPAGE="https://github.com/ogham/rust-number-prefix"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
