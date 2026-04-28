# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo_metadata"
CRATE_VERSION="0.21.0"
CRATE_CHECKSUM="5cfca2aaa699835ba88faf58a06342a314a950d2b9686165e038286c30316868"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="structured access to the output of \`cargo metadata\`"
HOMEPAGE="https://github.com/oli-obk/cargo_metadata"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"builder"
	"default"
	"unstable"
)
