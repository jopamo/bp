# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="whoami"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="6994d13118ab492c3c80c1f81928718159254c53c472bf9ce36f8dae4add02a7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Retrieve the current user and environment."
HOMEPAGE="https://github.com/ardaku/whoami/blob/v1/CHANGELOG.md"
LICENSE="|| ( Apache-2.0 BSL-1.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"web"
)
