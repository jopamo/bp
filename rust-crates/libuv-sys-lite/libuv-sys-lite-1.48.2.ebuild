# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libuv-sys-lite"
CRATE_VERSION="1.48.2"
CRATE_CHECKSUM="ca8dfd1a173826d193e3b955e07c22765829890f62c677a59c4a410cb4f47c01"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tiny, raw bindings to libuv without linking to it"
HOMEPAGE="https://github.com/nathanwhit/libuv-sys-lite"
LICENSE="non-standard"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"dyn-symbols"
	"warn-missing"
)
