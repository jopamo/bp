# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bincode"
CRATE_VERSION="1.3.3"
CRATE_CHECKSUM="b1f45e9417d87227c7a56d22e471c6206462cba514c7590c09aff4cf6d1ddcad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A binary serialization / deserialization strategy that uses Serde for transforming structs into bytes and vice versa!"
HOMEPAGE="https://github.com/servo/bincode"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"i128"
)
