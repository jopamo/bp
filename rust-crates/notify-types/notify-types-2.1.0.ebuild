# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="notify-types"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="42b8cfee0e339a0337359f3c88165702ac6e600dc01c0cc9579a92d62b08477a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types used by the notify crate"
HOMEPAGE="https://github.com/notify-rs/notify"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
	"serialization-compat-6"
)
