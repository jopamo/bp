# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ppv-lite86"
CRATE_VERSION="0.2.21"
CRATE_CHECKSUM="85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform cryptography-oriented low-level SIMD library."
HOMEPAGE="https://github.com/cryptocorrosion/cryptocorrosion"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no_simd"
	"simd"
	"std"
)
