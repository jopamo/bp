# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="dary_heap"
CRATE_VERSION="0.3.8"
CRATE_CHECKSUM="06d2e3287df1c007e74221c49ca10a95d557349e54b3a75dc2fb14712c751f04"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A d-ary heap"
HOMEPAGE="https://github.com/hanmertens/dary_heap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"extra"
	"unstable"
	"unstable_nightly"
)
