# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="leb128fmt"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to encode and decode LEB128 compressed integers."
HOMEPAGE="https://github.com/bluk/leb128fmt"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
