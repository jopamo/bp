# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="boxcar"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="36f64beae40a84da1b4b26ff2761a5b895c12adc41dc25aaee1c4f2bbfe97a6e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A concurrent, append-only vector"
HOMEPAGE="https://github.com/ibraheemdev/boxcar"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
