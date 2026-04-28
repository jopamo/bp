# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete_command"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="da8e198c052315686d36371e8a3c5778b7852fc75cc313e4e11eeb7a644a1b62"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Reduces boilerplate for adding a shell completion command to Clap"
HOMEPAGE="https://github.com/nihaals/clap-complete-command"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"carapace"
	"default"
	"fig"
	"nushell"
)
