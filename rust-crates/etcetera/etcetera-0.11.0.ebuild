# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="etcetera"
CRATE_VERSION="0.11.0"
CRATE_CHECKSUM="de48cc4d1c1d97a20fd819def54b890cadde72ed3ad0c614822a0a433361be96"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An unopinionated library for obtaining configuration, data, cache, & other directories"
HOMEPAGE="https://github.com/lunacookies/etcetera"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
