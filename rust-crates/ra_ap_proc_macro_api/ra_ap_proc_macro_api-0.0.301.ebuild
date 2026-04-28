# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_proc_macro_api"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="45db9e2df587d56f0738afa89fb2c100ff7c1e9cbe49e07f6a8b62342832211b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="RPC Api for the \`proc-macro-srv\` crate of rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
