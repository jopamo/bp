# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ureq"
CRATE_VERSION="3.2.0"
CRATE_CHECKSUM="fdc97a28575b85cfedf2a7e7d3cc64b3e11bd8ac766666318003abbacc7a21fc"
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
