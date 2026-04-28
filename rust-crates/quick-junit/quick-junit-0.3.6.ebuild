# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quick-junit"
CRATE_VERSION="0.3.6"
CRATE_CHECKSUM="d1a341ae463320e9f8f34adda49c8a85d81d4e8f34cce4397fb0350481552224"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Data model and serializer for JUnit/XUnit XML"
HOMEPAGE="https://github.com/nextest-rs/quick-junit"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
