# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ptr_meta_derive"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="16b845dbfca988fa33db069c0e230574d15a3088f147a87b64c7589eb662c9ac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for ptr_meta"
HOMEPAGE="https://github.com/djkoloski/ptr_meta"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
