# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="strip-ansi-escapes"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="55ff8ef943b384c414f54aefa961dd2bd853add74ec75e7ac74cf91dba62bcfa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Strip ANSI escape sequences from byte streams."
HOMEPAGE="https://github.com/luser/strip-ansi-escapes"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
