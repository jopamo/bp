# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="der-parser"
CRATE_VERSION="10.0.0"
CRATE_CHECKSUM="07da5016415d5a3c4dd39b11ed26f915f52fc4e0dc197d87908bc916e51bc1a6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser/encoder for ASN.1 BER/DER data"
HOMEPAGE="https://github.com/rusticata/der-parser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"as_bitvec"
	"bigint"
	"default"
	"serialize"
	"std"
	"unstable"
)
