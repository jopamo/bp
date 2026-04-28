# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="compact_str"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="f86b9c4c00838774a6d902ef931eff7470720c51d90c2e32cfe15dc304737b3f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A memory efficient string type that transparently stores strings on the stack, when possible"
HOMEPAGE="https://github.com/ParkMyCar/compact_str"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
