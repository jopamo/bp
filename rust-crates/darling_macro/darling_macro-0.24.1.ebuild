# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="darling_macro"
CRATE_VERSION="0.24.1"
CRATE_CHECKSUM="2ac7135c3ef02b2f7833bbeb1be5ba7f966dcde8a87c6b87f65a778d71a02785"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal support for a proc-macro library for reading attributes into structs when implementing custom derives. Use https://crates.io/crates/darling in your code."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
