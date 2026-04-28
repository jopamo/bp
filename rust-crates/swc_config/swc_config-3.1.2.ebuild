# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_config"
CRATE_VERSION="3.1.2"
CRATE_CHECKSUM="72e90b52ee734ded867104612218101722ad87ff4cf74fe30383bd244a533f97"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types for configuring swc"
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"file_pattern"
	"glob"
	"regex"
	"regex_js"
	"sourcemap"
)
