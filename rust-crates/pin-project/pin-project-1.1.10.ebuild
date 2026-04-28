# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-project"
CRATE_VERSION="1.1.10"
CRATE_CHECKSUM="677f1add503faace112b9f1373e43e9e054bfdd22ff1a63c1bc485eaec6a6a8a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for safe and ergonomic pin-projection."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
