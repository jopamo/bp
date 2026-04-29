# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="filetime"
CRATE_VERSION="0.2.24"
CRATE_CHECKSUM="bf401df4a4e3872c4fe8151134cf483738e74b67fc934d6532c882b3d24a4550"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
