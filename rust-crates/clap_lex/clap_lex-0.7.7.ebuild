# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_lex"
CRATE_VERSION="0.7.7"
CRATE_CHECKSUM="c3e64b0cc0439b12df2fa678eae89a1c56a529fd067a9115f7827f1fffd22b32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal, flexible command line parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
