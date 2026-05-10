# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gloo-timers"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="bbb143cf96099802033e0d4f4963b19fd2e0b728bcf076cd9cf7f6634f092994"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convenience crate for working with JavaScript timers"
HOMEPAGE="https://github.com/rustwasm/gloo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures"
)
