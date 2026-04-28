# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sha1"
CRATE_VERSION="0.10.6"
CRATE_CHECKSUM="e3bf829a2d51ab4a5ddf1352d8470c140cadc8301b2ae1789db023f01cedd6ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SHA-1 hash function"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"asm"
	"compress"
	"default"
	"force-soft"
	"loongarch64_asm"
	"oid"
	"std"
)
