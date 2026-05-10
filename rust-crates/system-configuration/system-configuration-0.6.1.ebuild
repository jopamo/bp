# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="system-configuration"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="3c879d448e9d986b661742763247d3693ed13609438cf3d006f51f5368a5ba6b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to SystemConfiguration framework for macOS"
HOMEPAGE="https://github.com/mullvad/system-configuration-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
