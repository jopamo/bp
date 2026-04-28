# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nom"
CRATE_VERSION="7.1.3"
CRATE_CHECKSUM="d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A byte-oriented, zero-copy, parser combinators library"
HOMEPAGE="https://github.com/Geal/nom"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"docsrs"
	"std"
)
