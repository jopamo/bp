# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scroll"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="c1257cd4248b4132760d6524d6dda4e053bc648c9070b960929bf50cfb1e7add"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A suite of powerful, extensible, generic, endian-aware Read/Write traits for byte buffers"
HOMEPAGE="https://github.com/m4b/scroll"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"std"
)
