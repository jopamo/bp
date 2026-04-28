# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="typed-path"
CRATE_VERSION="0.12.3"
CRATE_CHECKSUM="8e28f89b80c87b8fb0cf04ab448d5dd0dd0ade2f8891bae878de66a75a28600e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides typed variants of Path and PathBuf for Unix and Windows"
HOMEPAGE="https://github.com/chipsenkbeil/typed-path"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
