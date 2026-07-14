# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bitvec"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="ddcec3d12c579d40898fe0a9a358a803c23e9c52ca3c425707f81c9436211837"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Addresses memory by bits, for packed collections and bitfields"
HOMEPAGE="https://bitvecto-rs.github.io/bitvec"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"atomic"
	"default"
	"std"
	"testing"
)
