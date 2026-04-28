# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_transforms_classes"
CRATE_VERSION="27.0.0"
CRATE_CHECKSUM="108d4d52db6151f768a516fe86e6f21fc783b03fa2d20292999f29275fd0c71d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper for transforms for the swc project"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
