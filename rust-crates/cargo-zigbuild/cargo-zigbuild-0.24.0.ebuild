# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-zigbuild"
CRATE_VERSION="0.24.0"
CRATE_CHECKSUM="cfd0dbe23ae1b71e74014ba62e3262d6b2fdf76251828644823bdfd21ce5d84e"
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
