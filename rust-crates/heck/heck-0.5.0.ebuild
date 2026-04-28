# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="heck"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="heck is a case conversion library."
HOMEPAGE="https://github.com/withoutboats/heck"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
