# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap_complete_nushell"
CRATE_VERSION="4.6.0"
CRATE_CHECKSUM="fbb9e9715d29a754b468591be588f6b926f5b0a1eb6a8b62acabeb66ff84d897"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generator library used with clap for Nushell completion scripts"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unstable-shell-tests"
)
