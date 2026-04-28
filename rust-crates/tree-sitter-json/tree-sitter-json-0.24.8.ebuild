# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter-json"
CRATE_VERSION="0.24.8"
CRATE_CHECKSUM="4d727acca406c0020cffc6cf35516764f36c8e3dc4408e5ebe2cb35a947ec471"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JSON grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-json"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
