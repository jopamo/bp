# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wtf8"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="c01ae8492c38f52376efd3a17d0994b6bcf3df1e39c0226d458b7d81670b2a06"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of the WTF-8 encoding. https://simonsapin.github.io/wtf-8/"
HOMEPAGE="https://github.com/SimonSapin/rust-wtf8"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
