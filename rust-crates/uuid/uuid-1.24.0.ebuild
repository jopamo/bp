# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="uuid"
CRATE_VERSION="1.24.0"
CRATE_CHECKSUM="bf3923a6f5c4c6382e0b653c4117f48d631ea17f38ed86e2a828e6f7412f5239"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to generate and parse UUIDs."
HOMEPAGE="https://github.com/uuid-rs/uuid"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"atomic"
	"borsh"
	"default"
	"fast-rng"
	"js"
	"macro-diagnostics"
	"md5"
	"rng"
	"rng-getrandom"
	"rng-rand"
	"serde"
	"sha1"
	"std"
	"v1"
	"v3"
	"v4"
	"v5"
	"v6"
	"v7"
	"v8"
)
