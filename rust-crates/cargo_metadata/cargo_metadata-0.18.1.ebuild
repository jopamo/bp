# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo_metadata"
CRATE_VERSION="0.18.1"
CRATE_CHECKSUM="2d886547e41f740c616ae73108f6eb70afe6d940c7bc697cb30f13daec073037"
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
