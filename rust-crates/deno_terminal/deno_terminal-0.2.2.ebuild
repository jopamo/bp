# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_terminal"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="23f71c27009e0141dedd315f1dfa3ebb0a6ca4acce7c080fac576ea415a465f6"
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
