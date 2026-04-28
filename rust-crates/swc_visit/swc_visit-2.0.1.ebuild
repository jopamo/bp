# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_visit"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="62fb71484b486c185e34d2172f0eabe7f4722742aad700f426a494bb2de232a2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Visitor generator for stable rustc"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"path"
)
