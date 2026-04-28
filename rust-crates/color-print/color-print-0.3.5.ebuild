# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="color-print"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="7a858372ff14bab9b1b30ea504f2a4bc534582aee3e42ba2d41d2a7baba63d5d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Colorize and stylize strings for terminal at compile-time, by using an HTML-like syntax"
HOMEPAGE="https://gitlab.com/dajoha/color-print"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"terminfo"
)
