# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anes"
CRATE_VERSION="0.1.6"
CRATE_CHECKSUM="4b46cbb362ab8752921c97e041f5e366ee6297bd428a31275b9fcf1e380f7299"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ANSI Escape Sequences provider & parser"
HOMEPAGE="https://github.com/zrzka/anes-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"parser"
)
