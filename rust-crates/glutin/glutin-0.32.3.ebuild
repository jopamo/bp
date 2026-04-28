# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glutin"
CRATE_VERSION="0.32.3"
CRATE_CHECKSUM="12124de845cacfebedff80e877bb37b5b75c34c5a4c89e47e1cdd67fb6041325"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform OpenGL context provider."
HOMEPAGE="https://github.com/rust-windowing/glutin"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"egl"
	"glx"
	"wayland"
	"wgl"
	"x11"
)
