# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="quinn"
CRATE_VERSION="0.11.9"
CRATE_CHECKSUM="b9e20a958963c291dc322d98411f541009df2ced7b5a4f2bd52337638cfccf20"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Versatile QUIC transport protocol implementation"
HOMEPAGE="https://github.com/quinn-rs/quinn"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"aws-lc-rs-fips"
	"bloom"
	"default"
	"lock_tracking"
	"log"
	"platform-verifier"
	"qlog"
	"ring"
	"runtime-async-std"
	"runtime-smol"
	"runtime-tokio"
	"rustls"
	"rustls-aws-lc-rs"
	"rustls-aws-lc-rs-fips"
	"rustls-log"
	"rustls-ring"
)
