# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="reqwest-middleware"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="199dda04a536b532d0cc04d7979e39b1c763ea749bf91507017069c00b96056f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrapper around reqwest to allow for client middleware chains."
HOMEPAGE="https://github.com/TrueLayer/reqwest-middleware"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"charset"
	"form"
	"http2"
	"json"
	"multipart"
	"query"
	"rustls"
)
