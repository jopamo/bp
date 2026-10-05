# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tokio-eld"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="d06d816c6ab33079aa237f8d8a1f0f2018eb5cbd4096713f42c33aacf2502518"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Histogram-based sampler for recording and analyzing event loop delays"
HOMEPAGE="https://crates.io/crates/tokio-eld"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
