# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sm3"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="ebb9a3b702d0a7e33bc4d85a14456633d2b165c2ad839c5fd9a8417c1ab15860"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SM3 (OSCCA GM/T 0004-2012) hash function"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
