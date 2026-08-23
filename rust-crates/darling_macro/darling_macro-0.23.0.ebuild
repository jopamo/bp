# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="darling_macro"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="ac3984ec7bd6cfa798e62b4a642426a5be0e68f9401cfc2a01e3fa9ea2fcdb8d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal support for a proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
