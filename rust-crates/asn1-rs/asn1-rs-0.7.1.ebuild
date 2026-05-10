# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="asn1-rs"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="56624a96882bb8c26d61312ae18cb45868e5a9992ea73c58e45c3101e56a1e60"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser/encoder for ASN.1 BER/DER data"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bigint"
	"bits"
	"datetime"
	"debug"
	"default"
	"serialize"
	"std"
	"trace"
)
