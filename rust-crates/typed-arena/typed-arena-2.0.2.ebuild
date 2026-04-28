# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="typed-arena"
CRATE_VERSION="2.0.2"
CRATE_CHECKSUM="6af6ae20167a9ece4bcb41af5b80f8a1f1df981f6391189ce00fd257af04126a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The arena, a fast but limited type of allocator"
HOMEPAGE="https://github.com/SimonSapin/rust-typed-arena"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
