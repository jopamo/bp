# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="const-random-macro"
CRATE_VERSION="0.1.16"
CRATE_CHECKSUM="f9d839f2a20b0aee515dc581a6172f2321f96cab76c1a38a4c584a194955390e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides the procedural macro used by const-random"
HOMEPAGE="https://github.com/tkaitchuck/constrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
