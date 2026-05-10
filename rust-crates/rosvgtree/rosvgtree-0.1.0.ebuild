# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rosvgtree"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="bdc23d1ace03d6b8153c7d16f0708cd80b61ee8e80304954803354e67e40d150"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Represent an SVG as a read-only tree."
HOMEPAGE="https://github.com/RazrFalcon/resvg"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
