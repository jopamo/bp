# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libloading"
CRATE_VERSION="0.8.5"
CRATE_CHECKSUM="4979f22fdb869068da03c9f7528f8297c6fd2606bc3a4affe42e6a823fdb8da4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings around the platform's dynamic library loading primitives with greatly improved memory safety."
HOMEPAGE="https://github.com/nagisa/rust_libloading/"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
