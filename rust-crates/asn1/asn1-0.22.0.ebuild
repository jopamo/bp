# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="asn1"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="df42c2b01c5e1060b8281f67b4e5fb858260694916a667345a7305cd11e5dbfa"
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
