# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ptr_meta_derive"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="7347867d0a7e1208d93b46767be83e2b8f978c3dad35f775ac8d8847551d6fe1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for ptr_meta"
HOMEPAGE="https://github.com/rkyv/ptr_meta"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
