# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ucd-trie"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="2896d95c02a80c6d6a5d6e953d479f5ddf2dfdb6a244441010e373ac0fb88971"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A trie for storing Unicode codepoint sets and maps."
HOMEPAGE="https://github.com/BurntSushi/ucd-generate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
