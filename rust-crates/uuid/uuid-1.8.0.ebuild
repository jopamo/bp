# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="uuid"
CRATE_VERSION="1.8.0"
CRATE_CHECKSUM="a183cf7feeba97b4dd1c0d46788634f6221d87fa961b305bed08c851829efcc0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to generate and parse UUIDs."
HOMEPAGE="https://github.com/uuid-rs/uuid"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
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
