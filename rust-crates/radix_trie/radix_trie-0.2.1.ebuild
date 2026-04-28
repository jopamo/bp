# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="radix_trie"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="c069c179fcdc6a2fe24d8d18305cf085fdbd4f922c041943e203685d6a1c58fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generic radix trie data-structure."
HOMEPAGE="https://github.com/michaelsproul/rust_radix_trie"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
