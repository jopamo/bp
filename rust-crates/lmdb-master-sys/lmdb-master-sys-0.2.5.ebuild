# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="lmdb-master-sys"
CRATE_VERSION="0.2.5"
CRATE_CHECKSUM="864808e0b19fb6dd3b70ba94ee671b82fce17554cf80aeb0a155c65bb08027df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for liblmdb on the mdb.master branch."
HOMEPAGE="https://github.com/meilisearch/heed/tree/main/lmdb-master-sys"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asan"
	"default"
	"fuzzer"
	"fuzzer-no-link"
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
	"use-valgrind"
)
