# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hash32"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="47d60b12902ba28e2730cd37e95b8c9223af2808df9e902d4df49588d1470606"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="32-bit hashing algorithms"
HOMEPAGE="https://github.com/japaric/hash32"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
