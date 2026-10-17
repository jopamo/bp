# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="uuid"
CRATE_VERSION="1.23.4"
CRATE_CHECKSUM="bf80a72845275afea99e7f2b434723d3bc7e38470fcd1c7ed39a599c73319a53"
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
