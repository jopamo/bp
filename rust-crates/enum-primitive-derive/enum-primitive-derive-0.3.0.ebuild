# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="enum-primitive-derive"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="ba7795da175654fe16979af73f81f26a8ea27638d8d9823d317016888a63dc4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="enum_primitive implementation using procedural macros to have a custom derive"
HOMEPAGE="https://gitlab.com/cardoe/enum-primitive-derive"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
