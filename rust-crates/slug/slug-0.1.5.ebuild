# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="slug"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="3bd94acec9c8da640005f8e135a39fc0372e74535e6b368b7a04b875f784c8c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Convert a unicode string to a slug"
HOMEPAGE="https://github.com/Stebalien/slug-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
