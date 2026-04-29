# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="uuid"
CRATE_VERSION="1.23.0"
CRATE_CHECKSUM="5ac8b6f42ead25368cf5b098aeb3dc8a1a2c05a3eee8a9a1a68c640edbfc79d9"
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
