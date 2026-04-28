# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustversion"
CRATE_VERSION="1.0.15"
CRATE_CHECKSUM="80af6f9131f277a45a3fba6ce8e2258037bb0477a67e610d3c1fe046ab31de47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conditional compilation according to rustc compiler version"
HOMEPAGE="https://github.com/dtolnay/rustversion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
