# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cfg_aliases"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny utility to help save you a lot of effort with long winded `#[cfg()]` checks."
HOMEPAGE="https://github.com/katharostech/cfg_aliases"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
