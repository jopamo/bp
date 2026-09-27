# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schemars_derive"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="d98c67716b46af2f0b8cf752abc930f6f9aecfbf671ecfb531db8a31dbe4e2ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for #[derive(JsonSchema)], for use with schemars"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
