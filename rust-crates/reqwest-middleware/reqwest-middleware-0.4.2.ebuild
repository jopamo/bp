# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqwest-middleware"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="94edd851d407f55f1e91bae692ce072d82297de7e0455bee47335996b65e2390"
CRATE_SOURCE="git+https://github.com/astral-sh/reqwest-middleware?rev=7650ed76215a962a96d94a79be71c27bffde7ab2#7650ed76215a962a96d94a79be71c27bffde7ab2"
CRATE_SOURCE_KIND="git"

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
