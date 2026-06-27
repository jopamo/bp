# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-zigbuild"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="68c7df45b9d9934aaed5987fbf422b31419f81827b13a52251a61e1e772c6ff7"
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
