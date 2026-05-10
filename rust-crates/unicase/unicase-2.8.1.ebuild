# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicase"
CRATE_VERSION="2.8.1"
CRATE_CHECKSUM="75b844d17643ee918803943289730bec8aac480150456169e647ed0b576ba539"
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
