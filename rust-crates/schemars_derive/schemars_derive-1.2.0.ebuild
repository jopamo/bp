# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schemars_derive"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="4908ad288c5035a8eb12cfdf0d49270def0a268ee162b75eeee0f85d155a7c45"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for #[derive(JsonSchema)], for use with schemars"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
