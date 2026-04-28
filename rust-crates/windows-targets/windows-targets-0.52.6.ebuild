# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-targets"
CRATE_VERSION="0.52.6"
CRATE_CHECKSUM="9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libs for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
