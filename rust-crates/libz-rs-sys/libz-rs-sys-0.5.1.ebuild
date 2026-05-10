# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libz-rs-sys"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="172a788537a2221661b480fee8dc5f96c580eb34fa88764d3205dc356c7e4221"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A memory-safe zlib implementation written in rust"
HOMEPAGE="https://github.com/trifectatechfoundation/zlib-rs"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"c-allocator"
	"custom-prefix"
	"default"
	"export-symbols"
	"rust-allocator"
	"semver-prefix"
	"std"
	"testing-prefix"
)
