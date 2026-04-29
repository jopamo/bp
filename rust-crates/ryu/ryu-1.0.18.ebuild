# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ryu"
CRATE_VERSION="1.0.18"
CRATE_CHECKSUM="f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast floating point to string conversion"
HOMEPAGE="https://github.com/dtolnay/ryu"
LICENSE="|| ( Apache-2.0 BSL-1.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"small"
)
