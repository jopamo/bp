# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cgl"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="0ced0551234e87afee12411d535648dd89d2e7f34c78b753395567aff3d447ff"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for CGL on Mac"
HOMEPAGE="https://github.com/servo/cgl-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
