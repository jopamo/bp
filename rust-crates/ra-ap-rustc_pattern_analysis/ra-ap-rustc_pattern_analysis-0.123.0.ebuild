# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra-ap-rustc_pattern_analysis"
CRATE_VERSION="0.123.0"
CRATE_CHECKSUM="75b0ee1f059b9dea0818c6c7267478926eee95ba4c7dcf89c8db32fa165d3904"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package \`rustc_pattern_analysis\` in the rust-lang/rust repository from commit 052114f0c5e8d49f62f8caba364b07017310ab09 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"rustc"
)
