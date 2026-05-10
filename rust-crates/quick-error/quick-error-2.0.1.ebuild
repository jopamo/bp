# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quick-error"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A macro which makes error types pleasant to write."
HOMEPAGE="http://github.com/tailhook/quick-error"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
