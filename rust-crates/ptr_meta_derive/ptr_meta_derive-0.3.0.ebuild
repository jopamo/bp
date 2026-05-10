# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ptr_meta_derive"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="ca414edb151b4c8d125c12566ab0d74dc9cdba36fb80eb7b848c15f495fd32d1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for ptr_meta"
HOMEPAGE="https://github.com/rkyv/ptr_meta"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
