# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-zigbuild"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="9840ba8824cf43c7efb04a268090199072ad3ca8c65c386132909aee1bd4d4bf"
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
