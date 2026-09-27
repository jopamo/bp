# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustc-literal-escaper"
CRATE_VERSION="0.0.7"
CRATE_CHECKSUM="8be87abb9e40db7466e0681dc8ecd9dcfd40360cb10b4c8fe24a7c4c3669b198"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides code to unescape string literals"
HOMEPAGE="https://github.com/rust-lang/literal-escaper"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc-dep-of-std"
)
