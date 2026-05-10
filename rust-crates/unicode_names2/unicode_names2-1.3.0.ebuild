# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode_names2"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="d1673eca9782c84de5f81b82e4109dcfb3611c8ba0d52930ec4a9478f547b2dd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Map characters to and from their name given in the Unicode standard. This goes to great lengths to be as efficient as possible in both time and space, with the full bidirectional tables weighing barely 500 KB but still offering O(1)* look-up in both directions. (*more precisely, O(length of name).)"
HOMEPAGE="https://github.com/progval/unicode_names2"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-DFS-2016"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"generator-timing"
	"no_std"
	"unstable"
)
