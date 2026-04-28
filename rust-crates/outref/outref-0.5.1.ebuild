# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="outref"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="4030760ffd992bef45b0ae3f10ce1aba99e33464c90d14dd7c039884963ddc7a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Out reference"
HOMEPAGE="https://github.com/Nugine/outref"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
