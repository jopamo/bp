# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_parser"
CRATE_VERSION="27.0.7"
CRATE_CHECKSUM="7f1a51af1a92cd4904c073b293e491bbc0918400a45d58227b34c961dd6f52d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature-complete es2019 parser."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"tracing-spans"
	"typescript"
	"unstable"
	"verify"
)
