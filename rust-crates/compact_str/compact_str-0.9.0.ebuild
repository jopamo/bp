# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="compact_str"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="3fdb1325a1cece981e8a296ab8f0f9b63ae357bd0784a9faaf548cc7b480707a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A memory efficient string type that transparently stores strings on the stack, when possible"
HOMEPAGE="https://github.com/ParkMyCar/compact_str"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"borsh"
	"bytes"
	"default"
	"diesel"
	"markup"
	"proptest"
	"quickcheck"
	"rkyv"
	"serde"
	"smallvec"
	"sqlx"
	"sqlx-mysql"
	"sqlx-postgres"
	"sqlx-sqlite"
	"std"
	"zeroize"
)
