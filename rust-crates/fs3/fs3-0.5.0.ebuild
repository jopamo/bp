# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fs3"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="fb17cf6ed704f72485332f6ab65257460c4f9f3083934cf402bf9f5b3b600a90"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform file locks and file duplication."
HOMEPAGE="https://github.com/oxidecomputer/fs3-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
