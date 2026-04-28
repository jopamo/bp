# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cpufeatures"
CRATE_VERSION="0.2.12"
CRATE_CHECKSUM="53fe5e26ff1b7aef8bca9c6080520cfb8d9333c7568e1829cef191a9723e5504"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Lightweight runtime CPU feature detection for aarch64, loongarch64, and x86/x86_64 targets, with no_std support and support for mobile targets including Android and iOS"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
