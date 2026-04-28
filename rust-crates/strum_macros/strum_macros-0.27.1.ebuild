# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strum_macros"
CRATE_VERSION="0.27.1"
CRATE_CHECKSUM="c77a8c5abcaf0f9ce05d62342b7d298c346515365c36b673df4ebe3ced01fde8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helpful macros for working with enums and strings"
HOMEPAGE="https://github.com/Peternator7/strum"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
