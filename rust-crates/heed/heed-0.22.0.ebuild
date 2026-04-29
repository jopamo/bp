# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="heed"
CRATE_VERSION="0.22.0"
CRATE_CHECKSUM="6a56c94661ddfb51aa9cdfbf102cfcc340aa69267f95ebccc4af08d7c530d393"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fully typed LMDB (mdb.master) wrapper with minimum overhead"
HOMEPAGE="https://github.com/Kerollmops/heed"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary_precision"
	"default"
	"longer-keys"
	"mdb_idl_logn_10"
	"mdb_idl_logn_11"
	"mdb_idl_logn_12"
	"mdb_idl_logn_13"
	"mdb_idl_logn_14"
	"mdb_idl_logn_15"
	"mdb_idl_logn_16"
	"mdb_idl_logn_8"
	"mdb_idl_logn_9"
	"posix-sem"
	"preserve_order"
	"raw_value"
	"serde"
	"serde-bincode"
	"serde-json"
	"serde-rmp"
	"unbounded_depth"
	"use-valgrind"
)
