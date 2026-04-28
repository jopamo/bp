# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="intrusive-collections"
CRATE_VERSION="0.9.7"
CRATE_CHECKSUM="189d0897e4cbe8c75efedf3502c18c887b05046e59d28404d4d8e46cbc4d1e86"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Intrusive collections for Rust (linked list and red-black tree)"
HOMEPAGE="https://github.com/Amanieu/intrusive-rs"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"nightly"
)
