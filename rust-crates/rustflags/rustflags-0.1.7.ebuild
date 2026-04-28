# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustflags"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="a39e0e9135d7a7208ee80aa4e3e4b88f0f5ad7be92153ed70686c38a03db2e63"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for CARGO_ENCODED_RUSTFLAGS"
HOMEPAGE="https://github.com/dtolnay/rustflags"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
