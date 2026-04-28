# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossfont"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="a650099c323679b4d6fb6858c2c512660ff5118f6b0ffb1bfc6cadcd54002b14"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform native font loading and rasterization"
HOMEPAGE="https://github.com/alacritty/crossfont.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
