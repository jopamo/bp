# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="freetype-rs"
CRATE_VERSION="0.36.0"
CRATE_CHECKSUM="5442dee36ca09604133580dc0553780e867936bb3cbef3275859e889026d2b17"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings for FreeType font library"
HOMEPAGE="https://github.com/PistonDevelopers/freetype-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
