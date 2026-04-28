# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cli-table"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="14da8d951cef7cc4f13ccc9b744d736963d57863c7e6fc33c070ea274546082c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for printing tables on command line"
HOMEPAGE="https://github.com/devashishdxt/cli-table"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"doc"
	"title"
)
