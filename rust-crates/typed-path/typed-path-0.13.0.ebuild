# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="typed-path"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="9ce898823d8cd0f028662d2f349694b1af0a5cc9be83f1d213a00d3147445e1e"
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
	"nightly-wasip2"
	"serde"
	"std"
)
