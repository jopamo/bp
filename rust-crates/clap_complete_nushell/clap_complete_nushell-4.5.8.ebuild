# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap_complete_nushell"
CRATE_VERSION="4.5.8"
CRATE_CHECKSUM="0a0c951694691e65bf9d421d597d68416c22de9632e884c28412cb8cd8b73dce"
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
