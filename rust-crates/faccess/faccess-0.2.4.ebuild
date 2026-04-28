# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="faccess"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="59ae66425802d6a903e268ae1a08b8c38ba143520f227a205edf4e9c7e3e26d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple file accessibility checks"
HOMEPAGE="https://github.com/Freaky/faccess"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
