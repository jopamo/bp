# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reflink-copy"
CRATE_VERSION="0.1.28"
CRATE_CHECKSUM="23bbed272e39c47a095a5242218a67412a220006842558b03fe2935e8f3d7b92"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="copy-on-write mechanism on supported file systems"
HOMEPAGE="https://github.com/cargo-bins/reflink-copy"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"tracing"
)
