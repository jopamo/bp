# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hmac"
CRATE_VERSION="0.12.1"
CRATE_CHECKSUM="6c49c37c09c17a53d937dfbb742eb3a961d65a994e6bcdcf37e7399d0cc8ab5e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic implementation of Hash-based Message Authentication Code (HMAC)"
HOMEPAGE="https://github.com/RustCrypto/MACs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"reset"
	"std"
)
