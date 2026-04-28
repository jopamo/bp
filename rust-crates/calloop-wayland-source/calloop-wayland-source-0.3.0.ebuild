# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="calloop-wayland-source"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="95a66a987056935f7efce4ab5668920b5d0dac4a7c99991a67395f13702ddd20"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A wayland-rs client event source for callloop"
HOMEPAGE="https://github.com/smithay/calloop-wayland-source"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
