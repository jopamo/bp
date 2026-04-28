# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ucd-trie"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="ed646292ffc8188ef8ea4d1e0e0150fb15a5c2e12ad9b8fc191ae7a8a7f3c4b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A trie for storing Unicode codepoint sets and maps."
HOMEPAGE="https://github.com/BurntSushi/ucd-generate"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
