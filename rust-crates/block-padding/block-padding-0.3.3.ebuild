# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="block-padding"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="a8894febbff9f758034a5b8e12d87918f56dfc64a8e1fe757d65e29041538d93"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Padding and unpadding of messages divided into blocks."
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
