# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="universal-hash"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="fc1de2c688dc15305988b563c3854064043356019f97a4b46276fe734c4f07ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits which describe the functionality of universal hash functions (UHFs)"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
