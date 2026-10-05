# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="socket2"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="52d1cfed4120b4d927bf7c0f86d2087a4a7d6027c906d9f9d525a80573b9be51"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for handling networking sockets with a maximal amount of configuration possible intended."
HOMEPAGE="https://github.com/rust-lang/socket2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
)
