# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ureq-proto"
CRATE_VERSION="0.5.3"
CRATE_CHECKSUM="d81f9efa9df032be5934a46a068815a10a042b494b6a58cb0a1a97bb5467ed6f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ureq support crate"
HOMEPAGE="https://github.com/algesten/ureq-proto"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"client"
	"default"
	"server"
)
