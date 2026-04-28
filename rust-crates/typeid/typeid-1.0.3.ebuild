# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="typeid"
CRATE_VERSION="1.0.3"
CRATE_CHECKSUM="bc7d623258602320d5c55d1bc22793b57daff0ec7efc270ea7d55ce1d5f5471c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Const TypeId and non-'static TypeId"
HOMEPAGE="https://github.com/dtolnay/typeid"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
