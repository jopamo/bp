# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstream"
CRATE_VERSION="0.6.20"
CRATE_CHECKSUM="3ae563653d1938f79b1ab1b5e668c87c76a9930414574a6583a7b7e11a8e6192"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IO stream adapters for writing colored text that will gracefully degrade according to your terminal's capabilities."
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auto"
	"default"
	"test"
	"wincon"
)
