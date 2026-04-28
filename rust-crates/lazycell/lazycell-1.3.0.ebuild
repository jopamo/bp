# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lazycell"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="830d08ce1d1d941e6b30645f1a0eb5643013d835ce3779a5fc208261dbe10f55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library providing a lazily filled Cell struct"
HOMEPAGE="https://github.com/indiv0/lazycell"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
	"nightly-testing"
)
