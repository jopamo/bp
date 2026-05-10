# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bytecheck_derive"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="efb7846e0cb180355c2dec69e721edafa36919850f1a9f52ffba4ebc0393cb71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for bytecheck"
HOMEPAGE="https://github.com/rkyv/bytecheck"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
