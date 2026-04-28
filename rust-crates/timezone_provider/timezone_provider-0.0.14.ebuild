# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="timezone_provider"
CRATE_VERSION="0.0.14"
CRATE_CHECKSUM="f357f8e2cddee6a7b56b69fbb4cab30a7e82914c80ee7f9a5eb799ee3de3f24d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Time zone data providers"
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"datagen"
	"std"
)
