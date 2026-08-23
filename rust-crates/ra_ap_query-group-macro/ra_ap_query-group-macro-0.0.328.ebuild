# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_query-group-macro"
CRATE_VERSION="0.0.328"
CRATE_CHECKSUM="770079ca5addde33d31b7f3fa8d399f0dc29c26f69642a9d5c2a5e623d8af64d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro mimicking the \`#[salsa::query_group]\` macro for migrating to new Salsa"
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
