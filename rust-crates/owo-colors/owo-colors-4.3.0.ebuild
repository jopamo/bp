# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="owo-colors"
CRATE_VERSION="4.3.0"
CRATE_CHECKSUM="d211803b9b6b570f68772237e415a029d5a50c65d382910b879fb19d3271f94d"
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
