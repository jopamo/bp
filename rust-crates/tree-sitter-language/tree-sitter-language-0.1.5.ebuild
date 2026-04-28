# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter-language"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="c4013970217383f67b18aef68f6fb2e8d409bc5755227092d32efb0422ba24b8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The tree-sitter Language type, used by the library and by language implementations"
HOMEPAGE="https://tree-sitter.github.io/tree-sitter"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
