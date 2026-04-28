# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nom"
CRATE_VERSION="5.1.3"
CRATE_CHECKSUM="08959a387a676302eebf4ddbcbc611da04285579f76f88ee0506c63b1a61dd4b"
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
	"lexical"
	"regexp"
	"regexp_macros"
	"std"
)
