# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ref-cast-impl"
CRATE_VERSION="1.0.25"
CRATE_CHECKSUM="b7186006dcb21920990093f30e3dea63b7d6e977bf1256be20c3563a5db070da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive implementation for ref_cast::RefCast."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
