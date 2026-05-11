# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bcrypt"
CRATE_VERSION="0.19.1"
CRATE_CHECKSUM="24ae5479c93d3720e4c1dbd6b945b97457c50cb672781104768190371df1a905"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easily hash and verify passwords using bcrypt"
HOMEPAGE="https://github.com/Keats/rust-bcrypt"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
