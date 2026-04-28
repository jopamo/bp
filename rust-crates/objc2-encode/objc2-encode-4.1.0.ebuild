# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2-encode"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="ef25abbcd74fb2609453eb695bd2f860d389e457f67dc17cafc8b8cbc89d0c33"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Objective-C type-encoding representation and parsing"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
