# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winres"
CRATE_VERSION="0.1.12"
CRATE_CHECKSUM="b68db261ef59e9e52806f688020631e987592bd83619edccda9c47d42cde4f6c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Create and set windows icons and metadata for executables"
HOMEPAGE="https://github.com/mxre/winres"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
