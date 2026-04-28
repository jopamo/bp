# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tree-sitter-ql"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="80b7bcaf39acefbb199417a6ec2fd0c038083ba115da3e4f4426c820dc76d386"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semmle QL grammar for tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-ql"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
