# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-config2"
CRATE_VERSION="0.1.40"
CRATE_CHECKSUM="9821da7dd887f2a39d24a12415376dfc532200a7f9edbcf6bb97e96120a257e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Load and resolve Cargo configuration."
HOMEPAGE="https://github.com/taiki-e/cargo-config2"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
