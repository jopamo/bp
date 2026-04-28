# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unscanny"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="e9df2af067a7953e9c3831320f35c1cc0600c30d44d9f7a12b01db1cd88d6b47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Painless string scanning."
HOMEPAGE="https://github.com/typst/unscanny"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
