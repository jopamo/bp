# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="twox-hash"
CRATE_VERSION="2.1.0"
CRATE_CHECKSUM="e7b17f197b3050ba473acf9181f7b1d3b66d1cf7356c6cc57886662276e65908"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of the XXHash and XXH3 algorithms"
HOMEPAGE="https://github.com/shepmaster/twox-hash"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"random"
	"serialize"
	"std"
	"xxhash32"
	"xxhash3_128"
	"xxhash3_64"
	"xxhash64"
)
