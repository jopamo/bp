# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pathdiff"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="8835116a5c179084a830efb3adc117ab007512b535bc1a21c991d3b32a6b44dd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for diffing paths to obtain relative paths"
HOMEPAGE="https://github.com/Manishearth/pathdiff"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
