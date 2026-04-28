# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2-symbols"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="0a684efe3dec1b305badae1a28f6555f6ddd3bb2c2267896782858d5a78404dc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the Symbols framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"NSSymbolEffect"
	"all"
	"alloc"
	"default"
	"std"
)
