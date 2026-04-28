# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vswhom-sys"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="fb067e4cbd1ff067d1df46c9194b5de0e98efd2810bbc95c5d5e5f25a3231150"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure FFI to Jon Blow's VS discovery script"
HOMEPAGE="https://github.com/nabijaczleweli/vswhom-sys.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
