# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_lex"
CRATE_VERSION="0.7.5"
CRATE_CHECKSUM="b94f61472cee1439c0b966b47e3aca9ae07e45d070759512cd390ea2bebc6675"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal, flexible command line parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
