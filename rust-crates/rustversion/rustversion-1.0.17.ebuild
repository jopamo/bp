# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustversion"
CRATE_VERSION="1.0.17"
CRATE_CHECKSUM="955d28af4278de8121b7ebeb796b6a45735dc01436d898801014aced2773a3d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compilation according to rustc compiler version"
HOMEPAGE="https://github.com/dtolnay/rustversion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
