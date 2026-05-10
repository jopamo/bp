# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-reqwest-middleware"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="638d02e24aeb92f9537897cd1ff82e2bc98fd9ac9575a503e27bb07cdf64d4d7"
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
	"http2"
	"json"
	"multipart"
	"rustls-tls"
)
