# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle"
CRATE_VERSION="1.0.8"
CRATE_CHECKSUM="1bec1de6f59aedf83baf9ff929c98f2ad654b97c9510f4e70cf6f661d49fd5b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ANSI text styling"
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
