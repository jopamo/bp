# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libloading"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="b67380fd3b2fbe7527a606e18729d21c6f3951633d0500574c4dc22d2d638b9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings around the platform's dynamic library loading primitives with greatly improved memory safety."
HOMEPAGE="https://github.com/nagisa/rust_libloading/"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
