# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_lex"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="f46ad14479a25103f283c0f10005961cf086d8dc42205bb44c46ac563475dca6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal, flexible command line parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
