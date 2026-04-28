# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc32fast"
CRATE_VERSION="1.5.0"
CRATE_CHECKSUM="9481c1c90cbf2ac953f07c8d4a58aa3945c425b7185c9154d67a65e4230da511"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast, SIMD-accelerated CRC32 (IEEE) checksum computation"
HOMEPAGE="https://github.com/srijs/rust-crc32fast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)
