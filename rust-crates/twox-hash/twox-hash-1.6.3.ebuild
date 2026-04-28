# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="twox-hash"
CRATE_VERSION="1.6.3"
CRATE_CHECKSUM="97fee6b57c6a41524a810daee9286c02d7752c4253064d0b05472833a438f675"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of the XXHash and XXH3 algorithms"
HOMEPAGE="https://github.com/shepmaster/twox-hash"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serialize"
	"std"
)
