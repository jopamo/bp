# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num-derive"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="ed3955f1a9c7c0c15e092f9c887db08b1fc683305fdf6eb6684f22555355e202"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Numeric syntax extensions"
HOMEPAGE="https://github.com/rust-num/num-derive"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
