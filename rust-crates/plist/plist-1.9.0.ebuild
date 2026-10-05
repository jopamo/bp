# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="plist"
CRATE_VERSION="1.9.0"
CRATE_CHECKSUM="092791278e026273c1b65bbdcfbba3a300f2994c896bd01ab01da613c29c46f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A rusty plist parser. Supports Serde serialization."
HOMEPAGE="https://github.com/ebarnard/rust-plist/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"enable_unstable_features_that_may_break_with_minor_version_bumps"
)
