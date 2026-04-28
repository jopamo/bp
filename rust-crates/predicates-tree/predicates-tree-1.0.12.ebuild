# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="predicates-tree"
CRATE_VERSION="1.0.12"
CRATE_CHECKSUM="72dd2d6d381dfb73a193c7fca536518d7caee39fc8503f74e7dc0be0531b425c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Render boolean-valued predicate functions results as a tree."
HOMEPAGE="https://github.com/assert-rs/predicates-rs/tree/master/crates/tree"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
