# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_terminal"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="7e6337d4e7f375f8b986409a76fbeecfa4bd8a1343e63355729ae4befa058eaf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Terminal styling and other functionality used across Deno"
HOMEPAGE="https://github.com/denoland/deno_terminal"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"colors"
	"default"
)
