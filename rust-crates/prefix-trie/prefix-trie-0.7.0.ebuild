# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prefix-trie"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="85cf4c7c25f1dd66c76b451e9041a8cfce26e4ca754934fa7aed8d5a59a01d20"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Prefix trie (tree) datastructure (both a set and a map) that provides exact and longest-prefix matches."
HOMEPAGE="https://github.com/tiborschneider/prefix-trie"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"cidr"
	"default"
	"ipnet"
	"ipnetwork"
	"serde"
)
