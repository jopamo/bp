# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicase"
CRATE_VERSION="2.9.0"
CRATE_CHECKSUM="dbc4bc3a9f746d862c45cb89d705aa10f187bb96c76001afab07a0d35ce60142"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A case-insensitive wrapper around strings."
HOMEPAGE="https://github.com/seanmonstar/unicase"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
