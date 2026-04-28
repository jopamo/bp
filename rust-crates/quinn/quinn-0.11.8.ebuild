# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quinn"
CRATE_VERSION="0.11.8"
CRATE_CHECKSUM="626214629cda6781b6dc1d316ba307189c85ba657213ce642d9c77670f8202c8"
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
