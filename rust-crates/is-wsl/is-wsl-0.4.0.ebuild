# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is-wsl"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="173609498df190136aa7dea1a91db051746d339e18476eed5ca40521f02d7aa5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Checks if the process is running inside Windows Subsystem for Linux."
HOMEPAGE="https://github.com/TheLarkInn/is-wsl"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
