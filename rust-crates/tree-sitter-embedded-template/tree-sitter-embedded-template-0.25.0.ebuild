# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter-embedded-template"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="833d528e8fcb4e49ddb04d4d6450ddb8ac08f282a58fec94ce981c9c5dbf7e3a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Embedded Template (ERB, EJS) grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-embedded-template"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
