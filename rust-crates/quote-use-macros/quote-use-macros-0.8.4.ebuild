# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quote-use-macros"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="82ebfb7faafadc06a7ab141a6f67bcfb24cb8beb158c6fe933f2f035afa99f35"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support \`use\` in procmacros hygienically"
HOMEPAGE="https://github.com/ModProg/quote-use"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
