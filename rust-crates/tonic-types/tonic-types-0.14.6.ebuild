# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tonic-types"
CRATE_VERSION="0.14.6"
CRATE_CHECKSUM="73ab1b02061f83d519bba3caa167f88f261ef05720ab8ebc954ade70de3348e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of useful protobuf types that can be used with \`tonic\`."
HOMEPAGE="https://github.com/hyperium/tonic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
