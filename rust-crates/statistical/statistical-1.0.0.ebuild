# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="statistical"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="49d57902bb128e5e38b5218d3681215ae3e322d99f65d5420e9849730d2ea372"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple statistics library"
HOMEPAGE="https://github.com/JeffBelgum/statistical"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
