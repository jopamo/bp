# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="uuid"
CRATE_VERSION="1.22.0"
CRATE_CHECKSUM="a68d3c8f01c0cfa54a75291d83601161799e4a89a39e0929f4b0354d88757a37"
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
