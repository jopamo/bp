# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tree-sitter-language"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="009994f150cc0cd50ff54917d5bc8bffe8cad10ca10d81c34da2ec421ae61782"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The tree-sitter Language type, used by the library and by language implementations"
HOMEPAGE="https://tree-sitter.github.io/tree-sitter"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
