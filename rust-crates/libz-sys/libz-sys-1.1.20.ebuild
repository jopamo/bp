# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libz-sys"
CRATE_VERSION="1.1.20"
CRATE_CHECKSUM="d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level bindings to the system libz library (also known as zlib)."
HOMEPAGE="https://github.com/rust-lang/libz-sys"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"asm"
	"default"
	"static"
	"stock-zlib"
	"zlib-ng"
	"zlib-ng-no-cmake-experimental-community-maintained"
)
