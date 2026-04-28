# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yaml_parser"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="2a6a39b6b5ba0d02c910d05d7fbc366a4befb8901ea107dcde9c1c97acb8a366"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semi-tolerant YAML concrete syntax tree parser."
HOMEPAGE="https://github.com/g-plane/pretty_yaml"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
