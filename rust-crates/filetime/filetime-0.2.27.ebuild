# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="filetime"
CRATE_VERSION="0.2.27"
CRATE_CHECKSUM="f98844151eee8917efc50bd9e8318cb963ae8b297431495d3f758616ea5c57db"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
