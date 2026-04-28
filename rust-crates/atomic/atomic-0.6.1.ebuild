# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="atomic"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="a89cbf775b137e9b968e67227ef7f775587cde3fd31b0d8599dbd0f598a48340"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic Atomic<T> wrapper type"
HOMEPAGE="https://github.com/Amanieu/atomic-rs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fallback"
	"nightly"
	"serde"
	"std"
)
