# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashlink"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="e8094feaf31ff591f651a2664fb9cfd92bba7a60ce3197265e9482ebe753c8f7"
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
