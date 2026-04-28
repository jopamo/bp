# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="asn1-rs"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser/encoder for ASN.1 BER/DER data"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bigint"
	"bits"
	"datetime"
	"default"
	"serialize"
	"std"
)
