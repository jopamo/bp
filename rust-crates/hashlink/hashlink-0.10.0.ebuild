# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashlink"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="7382cf6263419f2d8df38c55d7da83da5c18aef87fc7a7fc1fb1e344edfe14c1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HashMap-like containers that hold their key-value pairs in a user controllable order"
HOMEPAGE="https://github.com/kyren/hashlink"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde_impl"
)
