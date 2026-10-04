# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cpufeatures"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="5ca28b0ae3115b884660db4118d803791fd6756b6e88f39c0f3f7859060d7566"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight runtime CPU feature detection for aarch64, loongarch64, and x86/x86_64 targets, with no_std support and support for mobile targets including Android and iOS"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
