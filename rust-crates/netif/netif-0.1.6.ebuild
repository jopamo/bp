# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="netif"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="d29a01b9f018d6b7b277fef6c79fdbd9bf17bb2d1e298238055cafab49baa5ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="List the network interfaces on the system."
HOMEPAGE="https://crates.io/crates/netif"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
