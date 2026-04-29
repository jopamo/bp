# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="foldhash"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="77ce24cb58228fbb8aa041425bb1050850ac19177686ea6e0f41a70416f56fdb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast, non-cryptographic, minimally DoS-resistant hashing algorithm."
HOMEPAGE="https://github.com/orlp/foldhash"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)
