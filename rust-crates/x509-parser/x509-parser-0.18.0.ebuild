# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="x509-parser"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="eb3e137310115a65136898d2079f003ce33331a6c4b0d51f1531d1be082b6425"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for the X.509 v3 format (RFC 5280 certificates)"
HOMEPAGE="https://github.com/rusticata/x509-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"validate"
	"verify"
	"verify-aws"
)
