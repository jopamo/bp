# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="radium"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="dc33ff2d4973d518d823d61aa239014831e521c75da58e3df4840d3f47749d09"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable interfaces for maybe-atomic types"
HOMEPAGE="https://github.com/bitvecto-rs/radium"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
