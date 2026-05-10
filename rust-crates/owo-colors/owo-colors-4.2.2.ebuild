# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="owo-colors"
CRATE_VERSION="4.2.2"
CRATE_CHECKSUM="48dd4f4a2c8405440fd0462561f0e5806bd0f77e86f51c761481bdd4018b545e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-allocation terminal colors that'll make people go owo"
HOMEPAGE="https://github.com/owo-colors/owo-colors"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"supports-colors"
)
