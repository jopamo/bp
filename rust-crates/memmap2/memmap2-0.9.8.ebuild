# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.8"
CRATE_CHECKSUM="843a98750cd611cc2965a8213b53b43e715f13c37a9e096c6408e69990961db7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
