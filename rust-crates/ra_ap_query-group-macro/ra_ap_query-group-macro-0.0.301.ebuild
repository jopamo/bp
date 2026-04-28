# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_query-group-macro"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="5f182a4b05f004eabaa83250a5de7ea3a13a92c88f3cbe98bfa1880cd9fbce0a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro mimicking the \`#[salsa::query_group]\` macro for migrating to new Salsa"
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
