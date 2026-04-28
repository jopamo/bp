# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-zigbuild"
CRATE_VERSION="0.22.1"
CRATE_CHECKSUM="6a72970dc4f54505e68b934ae90af6040a3edea6af820f535421e00d510b7984"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compile Cargo project with zig as linker"
HOMEPAGE="https://github.com/rust-cross/cargo-zigbuild"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"universal2"
)
