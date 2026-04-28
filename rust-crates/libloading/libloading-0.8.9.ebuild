# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libloading"
CRATE_VERSION="0.8.9"
CRATE_CHECKSUM="d7c4b02199fee7c5d21a5ae7d8cfa79a6ef5bb2fc834d6e9058e89c825efdc55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings around the platform's dynamic library loading primitives with greatly improved memory safety."
HOMEPAGE="https://github.com/nagisa/rust_libloading/"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
