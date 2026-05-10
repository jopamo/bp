# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="attribute-derive-macro"
CRATE_VERSION="0.10.5"
CRATE_CHECKSUM="0a7cdbbd4bd005c5d3e2e9c885e6fa575db4f4a3572335b974d8db853b6beb61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Clap for proc macro attributes"
HOMEPAGE="https://github.com/ModProg/attribute-derive"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
