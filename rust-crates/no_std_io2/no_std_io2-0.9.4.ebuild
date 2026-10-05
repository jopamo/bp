# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="no_std_io2"
CRATE_VERSION="0.9.4"
CRATE_CHECKSUM="418abd1b6d34fbf6cae440dc874771b0525a604428704c76e48b29a5e67b8003"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The bare essentials of std::io for use in no_std. Alloc support is optional."
HOMEPAGE="https://github.com/wcampbell0x2a/no-std-io2"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"nightly"
	"std"
)
