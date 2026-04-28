# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zune-jpeg"
CRATE_VERSION="0.4.13"
CRATE_CHECKSUM="16099418600b4d8f028622f73ff6e3deaabdff330fb9a2a131dea781ee8b0768"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast, correct and safe jpeg decoder"
HOMEPAGE="https://github.com/etemesi254/zune-image/tree/dev/crates/zune-jpeg"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"log"
	"neon"
	"std"
	"x86"
)
