# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pin-project"
CRATE_VERSION="1.1.5"
CRATE_CHECKSUM="b6bf43b791c5b9e34c3d182969b4abb522f9343702850a2e57f460d00d09b4b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for safe and ergonomic pin-projection."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
