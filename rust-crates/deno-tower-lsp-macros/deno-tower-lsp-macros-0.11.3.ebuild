# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno-tower-lsp-macros"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="f9221b99f1cc7c395686b9f2d5652c5855666a9282c8d5a68fabd4b1d4994fa9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This is a fork of https://crates.io/crates/tower-lsp macros, used in Deno. At the moment only floating patches."
HOMEPAGE="https://github.com/ebkalderon/tower-lsp"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
