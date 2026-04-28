# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lscolors"
CRATE_VERSION="0.21.0"
CRATE_CHECKSUM="d60e266dfb1426eb2d24792602e041131fdc0236bb7007abc0e589acafd60929"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Colorize paths using the LS_COLORS environment variable"
HOMEPAGE="https://github.com/sharkdp/lscolors"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"gnu_legacy"
)
