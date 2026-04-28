# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_spanned"
CRATE_VERSION="0.6.9"
CRATE_CHECKSUM="bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde-compatible spanned Value"
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
