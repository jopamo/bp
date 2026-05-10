# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-reqwest-retry"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="78ab210f6cdf8fd3254d47e5ee27ce60ed34a428ff71b4ae9477b1c84b49498c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Retry middleware for reqwest."
HOMEPAGE="https://github.com/TrueLayer/reqwest-middleware"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tracing"
)
