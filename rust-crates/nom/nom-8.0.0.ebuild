# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nom"
CRATE_VERSION="8.0.0"
CRATE_CHECKSUM="df9761775871bdef83bee530e60050f7e54b1105350d6884eb0fb4f46c2f9405"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A byte-oriented, zero-copy, parser combinators library"
HOMEPAGE="https://github.com/rust-bakery/nom"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"docsrs"
	"std"
)
