# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="android_system_properties"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal Android system properties wrapper"
HOMEPAGE="https://github.com/nical/android_system_properties"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
