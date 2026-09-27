# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytecheck_derive"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="46d07918caa9eeaaf06b7873925c53a61daac173539b4f7715090745e44e4e69"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for bytecheck"
HOMEPAGE="https://github.com/rkyv/bytecheck"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
