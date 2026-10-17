# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="humantime"
CRATE_VERSION="2.4.0"
CRATE_CHECKSUM="15cdd26707701c53297e2fa6afb323d55fbc1d0810c3aec078ae3ef0424c3c15"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A parser and formatter for std::time::{Duration, SystemTime}"
HOMEPAGE="https://github.com/chronotope/humantime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"mu"
)
