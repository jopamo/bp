# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ureq"
CRATE_VERSION="3.3.0"
CRATE_CHECKSUM="dea7109cdcd5864d4eeb1b58a1648dc9bf520360d7af16ec26d0a9354bafcfc0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple, safe HTTP client"
HOMEPAGE="https://github.com/algesten/ureq"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_doc"
	"_ring"
	"_rustls"
	"_test"
	"_tls"
	"_url"
	"brotli"
	"charset"
	"cookies"
	"default"
	"gzip"
	"json"
	"multipart"
	"native-tls"
	"native-tls-no-default"
	"native-tls-webpki-roots"
	"platform-verifier"
	"rustls"
	"rustls-no-provider"
	"rustls-webpki-roots"
	"socks-proxy"
	"vendored"
	"win-system-proxy"
)
