# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="copypasta"
CRATE_VERSION="0.10.2"
CRATE_CHECKSUM="3e6811e17f81fe246ef2bc553f76b6ee6ab41a694845df1d37e52a92b7bbd38a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="copypasta is a cross-platform library for getting and setting the contents of the OS-level clipboard."
HOMEPAGE="https://github.com/alacritty/copypasta"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"wayland"
	"wayland-dlopen"
	"x11"
)
