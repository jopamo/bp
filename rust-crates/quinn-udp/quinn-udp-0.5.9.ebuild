# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quinn-udp"
CRATE_VERSION="0.5.9"
CRATE_CHECKSUM="1c40286217b4ba3a71d644d752e6a0b71f13f1b6a2c5311acfcbe0c2418ed904"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UDP sockets with ECN information for the QUIC transport protocol"
HOMEPAGE="https://github.com/quinn-rs/quinn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"direct-log"
	"fast-apple-datapath"
	"log"
)
