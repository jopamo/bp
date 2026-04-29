# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="quinn-udp"
CRATE_VERSION="0.5.14"
CRATE_CHECKSUM="addec6a0dcad8a8d96a771f815f0eaf55f9d1805756410b39f5fa81332574cbd"
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
