# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="doc-comment"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro to generate doc comments"
HOMEPAGE="https://github.com/GuillaumeGomez/doc-comment"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"no_core"
	"old_macros"
)
