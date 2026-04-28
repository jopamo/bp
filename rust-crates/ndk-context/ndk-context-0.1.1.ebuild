# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ndk-context"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="27b02d87554356db9e9a873add8782d4ea6e3e58ea071a9adb9a2e8ddb884a8b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Handles for accessing Android APIs"
HOMEPAGE="https://github.com/rust-windowing/android-ndk-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
