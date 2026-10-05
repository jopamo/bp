# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quinn-proto"
CRATE_VERSION="0.11.16"
CRATE_CHECKSUM="2f4bfc015262b9df63c8845072ce59068853ff5872180c2ce2f13038b970e560"
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
