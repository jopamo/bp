# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-cursor"
CRATE_VERSION="0.31.11"
CRATE_CHECKSUM="447ccc440a881271b19e9989f75726d60faa09b95b0200a9b7eb5cc47c3eeb29"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to libwayland-cursor."
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
