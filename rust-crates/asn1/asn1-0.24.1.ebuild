# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="asn1"
CRATE_VERSION="0.24.1"
CRATE_CHECKSUM="c9795210620c0cb3f9a7ce4f882808c38e1ef7b347c90591dceae0886e031fb1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ASN.1 (DER) parser and writer for Rust."
HOMEPAGE="https://github.com/alex/rust-asn1"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
