# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="const-random"
CRATE_VERSION="0.1.18"
CRATE_CHECKSUM="87e00182fe74b066627d63b85fd550ac2998d4b0bd86bfed477a0ae4c7c71359"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides compile time random number generation."
HOMEPAGE="https://github.com/tkaitchuck/constrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
