# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="option-ext"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="04744f49eae99ab78e0d5c0b603ab218f515ea8cfe5a456d7629ad883a3b6e7d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Extends `Option` with additional operations"
HOMEPAGE="https://github.com/soc/option-ext"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
