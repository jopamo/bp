# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sqlformat"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="a0d7b3e8a3b6f2ee93ac391a0f757c13790caa0147892e3545cd549dd5b54bc0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Formats whitespace in a SQL string to make it easier to read"
HOMEPAGE="https://github.com/shssoichiro/sqlformat-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
