# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro-crate"
CRATE_VERSION="3.4.0"
CRATE_CHECKSUM="219cb19e96be00ab2e37d6e299658a0cfa83e52429179969b0f0121b4ac46983"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Replacement for crate (macro_rules keyword) in proc-macros"
HOMEPAGE="https://github.com/bkchr/proc-macro-crate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
