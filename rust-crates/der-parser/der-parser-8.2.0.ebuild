# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="der-parser"
CRATE_VERSION="8.2.0"
CRATE_CHECKSUM="dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser/encoder for ASN.1 BER/DER data"
HOMEPAGE="https://github.com/rusticata/der-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bigint"
	"default"
	"serialize"
	"std"
	"unstable"
)
