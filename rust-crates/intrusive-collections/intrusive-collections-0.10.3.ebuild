# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="intrusive-collections"
CRATE_VERSION="0.10.3"
CRATE_CHECKSUM="4275b20e6057cd7733fd8df8a5a31701e4fe44497dad0f3fa0e1c4fb971506be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Intrusive collections for Rust (linked list and red-black tree)"
HOMEPAGE="https://github.com/Amanieu/intrusive-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"nightly"
)
