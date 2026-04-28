# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro-crate"
CRATE_VERSION="3.2.0"
CRATE_CHECKSUM="8ecf48c7ca261d60b74ab1a7b20da18bede46776b2e55535cb958eb595c5fa7b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Replacement for crate (macro_rules keyword) in proc-macros"
HOMEPAGE="https://github.com/bkchr/proc-macro-crate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
