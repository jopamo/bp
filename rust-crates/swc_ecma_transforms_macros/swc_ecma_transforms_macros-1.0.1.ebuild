# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_macros"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="bc777288799bf6786e5200325a56e4fbabba590264a4a48a0c70b16ad0cf5cd8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for swc_ecma_transforms."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
