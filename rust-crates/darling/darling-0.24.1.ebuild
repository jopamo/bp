# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="darling"
CRATE_VERSION="0.24.1"
CRATE_CHECKSUM="ed17f5901b6630b993ca003def43f2f8ef4014fc13b047b57aad617ff32bc2ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A proc-macro library for reading attributes into structs when implementing custom derives."
HOMEPAGE="https://github.com/TedDriggs/darling"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"diagnostics"
	"serde"
	"suggestions"
)
