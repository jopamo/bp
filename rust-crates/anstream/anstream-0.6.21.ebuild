# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstream"
CRATE_VERSION="0.6.21"
CRATE_CHECKSUM="43d5b281e737544384e969a5ccad3f1cdd24b48086a0fc1b2a5262a26b8f4f4a"
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
