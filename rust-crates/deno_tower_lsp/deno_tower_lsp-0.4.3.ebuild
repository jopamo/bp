# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_tower_lsp"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="67da3258ce785368c691b206d00d4109f8eead24da0603abc70e04b04871a3df"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This is a fork of https://crates.io/crates/tower-lsp, used in Deno. At the moment only floating patches."
HOMEPAGE="https://crates.io/crates/deno_tower_lsp"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"proposed"
)
