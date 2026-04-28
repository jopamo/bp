# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="httparse"
CRATE_VERSION="1.10.0"
CRATE_CHECKSUM="f2d708df4e7140240a16cd6ab0ab65c972d7433ab77819ea693fde9c43811e2a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny, safe, speedy, zero-copy HTTP/1.x parser."
HOMEPAGE="https://github.com/seanmonstar/httparse"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
