# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="manyhow-macros"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="46fce34d199b78b6e6073abf984c9cf5fd3e9330145a93ee0738a7443e371495"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for manyhow"
HOMEPAGE="https://github.com/ModProg/manyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
