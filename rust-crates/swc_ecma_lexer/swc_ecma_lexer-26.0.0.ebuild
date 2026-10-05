# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="swc_ecma_lexer"
CRATE_VERSION="26.0.0"
CRATE_CHECKSUM="5e82f7747e052c6ff6e111fa4adeb14e33b46ee6e94fe5ef717601f651db48fc"
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
	"verify"
)
