# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crc32fast"
CRATE_VERSION="1.4.2"
CRATE_CHECKSUM="a97769d94ddab943e4510d138150169a2758b5ef3eb191a9ee688de3e23ef7b3"
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
