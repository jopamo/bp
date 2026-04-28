# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_lex"
CRATE_VERSION="0.7.6"
CRATE_CHECKSUM="a1d728cc89cf3aee9ff92b05e62b19ee65a02b5702cff7d5a377e32c6ae29d8d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimal, flexible command line parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
