# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="kqueue-sys"
CRATE_VERSION="1.1.2"
CRATE_CHECKSUM="07293a4e297ac234359b510362495713f75ea345d5307140414f20c69ffeb087"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue-sys"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
