# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="bcrypt"
CRATE_VERSION="0.17.1"
CRATE_CHECKSUM="abaf6da45c74385272ddf00e1ac074c7d8a6c1a1dda376902bd6a427522a8b2c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Easily hash and verify passwords using bcrypt"
HOMEPAGE="https://github.com/Keats/rust-bcrypt"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
