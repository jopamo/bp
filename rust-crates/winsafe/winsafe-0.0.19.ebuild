# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winsafe"
CRATE_VERSION="0.0.19"
CRATE_CHECKSUM="d135d17ab770252ad95e9a872d365cf3090e3be864a34ab46f48555993efc904"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows API and GUI in safe, idiomatic Rust."
HOMEPAGE="https://github.com/rodrigocfd/winsafe"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"comctl"
	"dshow"
	"dwm"
	"dxgi"
	"gdi"
	"gui"
	"kernel"
	"mf"
	"ole"
	"oleaut"
	"shell"
	"taskschd"
	"user"
	"uxtheme"
	"version"
)
