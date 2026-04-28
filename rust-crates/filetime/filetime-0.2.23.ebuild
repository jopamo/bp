# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="filetime"
CRATE_VERSION="0.2.23"
CRATE_CHECKSUM="1ee447700ac8aa0b2f2bd7bc4462ad686ba06baa6727ac149a2d6277f0d240fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
