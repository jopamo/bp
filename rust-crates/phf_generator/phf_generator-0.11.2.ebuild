# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_generator"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="48e4cc64c2ad9ebe670cb8fd69dd50ae301650392e81c05f9bfcb2d5bdbc24b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PHF generation logic"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
