# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="p12"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="d4873306de53fe82e7e484df31e1e947d61514b6ea2ed6cd7b45d63006fd9224"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pure rust pkcs12 tool"
HOMEPAGE="https://github.com/hjiayz/p12"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
