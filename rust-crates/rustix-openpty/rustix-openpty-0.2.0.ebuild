# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustix-openpty"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="1de16c7c59892b870a6336f185dc10943517f1327447096bbb7bb32cd85e2393"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe Rust bindings to `openpty` and related functions"
HOMEPAGE="https://github.com/sunfishcode/rustix-openpty"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
