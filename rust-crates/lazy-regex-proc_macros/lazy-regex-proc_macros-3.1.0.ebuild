# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lazy-regex-proc_macros"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="44bcd58e6c97a7fcbaffcdc95728b393b8d98933bfadad49ed4097845b57ef0b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc macros for the lazy_regex crate"
HOMEPAGE="https://crates.io/crates/lazy-regex-proc_macros"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
