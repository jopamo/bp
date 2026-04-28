# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_lex"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="3a822ea5bc7590f9d40f1ba12c0dc3c2760f3482c6984db1573ad11031420831"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal, flexible command line parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
