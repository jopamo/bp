# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="yoke-derive"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="28cc31741b18cb6f1d5ff12f5b7523e3d6eb0852bbbad19d73905511d9849b95"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the yoke crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
