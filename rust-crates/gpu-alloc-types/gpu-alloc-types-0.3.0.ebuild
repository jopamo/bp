# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gpu-alloc-types"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="98ff03b468aa837d70984d55f5d3f846f6ec31fe34bbb97c4f85219caeee1ca4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core types of gpu-alloc crate"
HOMEPAGE="https://github.com/zakarumych/gpu-alloc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
