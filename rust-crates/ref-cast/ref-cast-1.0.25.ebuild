# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ref-cast"
CRATE_VERSION="1.0.25"
CRATE_CHECKSUM="f354300ae66f76f1c85c5f84693f0ce81d747e2c3f21a45fef496d89c960bf7d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safely cast &T to &U where the struct U contains a single field of type T."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
