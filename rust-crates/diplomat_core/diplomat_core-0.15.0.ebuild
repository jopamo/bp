# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="diplomat_core"
CRATE_VERSION="0.15.0"
CRATE_CHECKSUM="9cf41b94101a4bce993febaf0098092b0bb31deaf0ecaf6e0a2562465f61b383"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared utilities between Diplomat macros and code generation"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"hir"
)
