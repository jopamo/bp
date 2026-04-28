# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="block"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="0d8c1fef690941d3e7788d328517591fecc684c084084702d6ff1641e993699a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust interface for Apple's C language extension of blocks."
HOMEPAGE="http://github.com/SSheldon/rust-block"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
