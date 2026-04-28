# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cov-mark"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="3f1d92727879fb4f24cec33a35e3bff74035541326cbc12ad44ba8886d1927b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Manual coverage marks."
HOMEPAGE="https://github.com/matklad/cov-mark"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"enable"
)
