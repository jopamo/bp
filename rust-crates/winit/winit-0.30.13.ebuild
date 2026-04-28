# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winit"
CRATE_VERSION="0.30.13"
CRATE_CHECKSUM="a6755fa58a9f8350bd1e472d4c3fcc25f824ec358933bba33306d0b63df5978d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform window creation library."
HOMEPAGE="https://github.com/rust-windowing/winit"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"android-game-activity"
	"android-native-activity"
	"default"
	"mint"
	"rwh_04"
	"rwh_05"
	"rwh_06"
	"serde"
	"wayland"
	"wayland-csd-adwaita"
	"wayland-csd-adwaita-crossfont"
	"wayland-csd-adwaita-notitle"
	"wayland-dlopen"
	"x11"
)
