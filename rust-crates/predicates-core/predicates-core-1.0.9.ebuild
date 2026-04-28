# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="predicates-core"
CRATE_VERSION="1.0.9"
CRATE_CHECKSUM="727e462b119fe9c93fd0eb1429a5f7647394014cf3c04ab2c0350eeb09095ffa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An API for boolean-valued predicate functions."
HOMEPAGE="https://github.com/assert-rs/predicates-rs/tree/master/crates/core"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
