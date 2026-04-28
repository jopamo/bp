# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="data-url"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="5c297a1c74b71ae29df00c3e22dd9534821d60eb9af5a0192823fa2acea70c2a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Processing of data: URL according to WHATWG’s Fetch Standard"
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
