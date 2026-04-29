# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="ulid"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="470dbf6591da1b39d43c14523b2b469c86879a53e8b758c8e090a470fe7b1fbe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a Universally Unique Lexicographically Sortable Identifier implementation"
HOMEPAGE="https://github.com/dylanhart/ulid-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"postgres"
	"rkyv"
	"std"
)
