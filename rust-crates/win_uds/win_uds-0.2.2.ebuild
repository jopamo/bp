# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="win_uds"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="7dd30a1a28a3799479cbf4e17284a220ea9ff6bad098a9d0224543a5d1efe1da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows Unix Domain Socket"
HOMEPAGE="https://github.com/kouhe3/win_uds"
LICENSE="Unlicense"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
)
