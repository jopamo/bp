# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dialoguer"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="25f104b501bf2364e78d0d3974cbc774f738f5865306ed128e1e0d7499c0ad96"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A command line prompting library."
HOMEPAGE="https://github.com/console-rs/dialoguer"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"completion"
	"default"
	"editor"
	"fuzzy-select"
	"history"
	"password"
)
