# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hashlink"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="32069d97bb81e38fa67eab65e3393bf804bb85969f2bc06bf13f64aef5aba248"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HashMap-like containers that hold their key-value pairs in a user controllable order"
HOMEPAGE="https://github.com/djc/hashlink"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde_impl"
)
