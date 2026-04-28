# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fs_extra"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="42703706b716c37f96a77aea830392ad231f44c9e9a67872fa5548707e11b11c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Expanding std::fs and std::io. Recursively copy folders with information about process and much more."
HOMEPAGE="https://github.com/webdesus/fs_extra"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
