# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xkbcommon-dl"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="d039de8032a9a8856a6be89cea3e5d12fdd82306ab7c94d74e6deab2460651c5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Dynamically loaded xkbcommon and xkbcommon-x11 Rust bindings."
HOMEPAGE="https://github.com/rust-windowing/xkbcommon-dl"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"x11"
)
