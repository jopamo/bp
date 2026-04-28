# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nu-ansi-term"
CRATE_VERSION="0.50.1"
CRATE_CHECKSUM="d4a28e057d01f97e61255210fcff094d74ed0466038633e95017f5beb68e4399"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for ANSI terminal colors and styles (bold, underline)"
HOMEPAGE="https://github.com/nushell/nu-ansi-term"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"derive_serde_style"
	"gnu_legacy"
)
