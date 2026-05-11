# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="crypto-common"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="77727bb15fa921304124b128af125e7e3b968275d1b108b379190264f4423710"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common traits used by cryptographic algorithms"
HOMEPAGE="https://github.com/RustCrypto/traits"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"getrandom"
	"rand_core"
	"zeroize"
)
