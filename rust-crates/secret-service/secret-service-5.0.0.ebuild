# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="secret-service"
CRATE_VERSION="5.0.0"
CRATE_CHECKSUM="dccff79e916a339eec808de579764e3459658c903960d5aa4f7959ee9f6d5f2b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to interface with Secret Service API"
HOMEPAGE="https://github.com/hwchen/secret-service-rs.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"crypto-openssl"
	"crypto-rust"
	"rt-async-io-crypto-openssl"
	"rt-async-io-crypto-rust"
	"rt-tokio-crypto-openssl"
	"rt-tokio-crypto-rust"
)
