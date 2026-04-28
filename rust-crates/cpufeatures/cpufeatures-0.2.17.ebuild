# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cpufeatures"
CRATE_VERSION="0.2.17"
CRATE_CHECKSUM="59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight runtime CPU feature detection for aarch64, loongarch64, and x86/x86_64 targets, with no_std support and support for mobile targets including Android and iOS"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
