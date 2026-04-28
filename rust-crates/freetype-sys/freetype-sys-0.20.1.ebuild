# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="freetype-sys"
CRATE_VERSION="0.20.1"
CRATE_CHECKSUM="0e7edc5b9669349acfda99533e9e0bcf26a51862ab43b08ee7745c55d28eb134"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low level binding for FreeType font library"
HOMEPAGE="https://github.com/PistonDevelopers/freetype-sys"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
