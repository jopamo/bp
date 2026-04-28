# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="msi"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="4a2332f87a064dea9cce571408c879e0da8dc193b3af06a2b3b2604ee4182a32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read/write Windows Installer (MSI) files"
HOMEPAGE="https://github.com/mdsteele/rust-msi"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
