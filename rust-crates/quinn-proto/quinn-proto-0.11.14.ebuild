# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="quinn-proto"
CRATE_VERSION="0.11.14"
CRATE_CHECKSUM="434b42fec591c96ef50e21e886936e66d3cc3f737104fdb9b737c40ffb94c098"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="State machine for the QUIC transport protocol"
HOMEPAGE="https://github.com/quinn-rs/quinn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__rustls-post-quantum-test"
	"aws-lc-rs"
	"aws-lc-rs-fips"
	"bloom"
	"default"
	"log"
	"platform-verifier"
	"qlog"
	"ring"
	"rustls"
	"rustls-aws-lc-rs"
	"rustls-aws-lc-rs-fips"
	"rustls-log"
	"rustls-ring"
)
