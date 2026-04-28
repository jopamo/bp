# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="which"
CRATE_VERSION="8.0.0"
CRATE_CHECKSUM="d3fabb953106c3c8eea8306e4393700d7657561cb43122571b172bbfb7c7ba1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust equivalent of Unix command \"which\". Locate installed executable in cross platforms."
HOMEPAGE="https://github.com/harryfei/which-rs.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"real-sys"
	"regex"
	"tracing"
)
