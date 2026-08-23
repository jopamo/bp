# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustc-literal-escaper"
CRATE_VERSION="0.0.5"
CRATE_CHECKSUM="e4ee29da77c5a54f42697493cd4c9b9f31b74df666a6c04dfc4fde77abe0438b"
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
