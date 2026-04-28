# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustversion"
CRATE_VERSION="1.0.22"
CRATE_CHECKSUM="b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compilation according to rustc compiler version"
HOMEPAGE="https://github.com/dtolnay/rustversion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
