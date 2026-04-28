# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vswhom"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="be979b7f07507105799e854203b470ff7c78a1639e330a58f183b5fea574608b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI to Jon Blow's VS discovery script"
HOMEPAGE="https://github.com/nabijaczleweli/vswhom.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
