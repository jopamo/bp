# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="x509-parser"
CRATE_VERSION="0.15.1"
CRATE_CHECKSUM="7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser for the X.509 v3 format (RFC 5280 certificates)"
HOMEPAGE="https://github.com/rusticata/x509-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"validate"
	"verify"
)
