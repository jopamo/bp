# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter-ruby"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="be0484ea4ef6bb9c575b4fdabde7e31340a8d2dbc7d52b321ac83da703249f95"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ruby grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-ruby"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
