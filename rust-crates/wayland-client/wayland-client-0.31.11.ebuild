# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wayland-client"
CRATE_VERSION="0.31.11"
CRATE_CHECKSUM="c66a47e840dc20793f2264eb4b3e4ecb4b75d91c0dd4af04b456128e0bdd449d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the standard C implementation of the wayland protocol, client side."
HOMEPAGE="https://github.com/smithay/wayland-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
