# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="smol_str"
CRATE_VERSION="0.3.6"
CRATE_CHECKSUM="4aaa7368fcf4852a4c2dd92df0cace6a71f2091ca0a23391ce7f3a31833f1523"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="small-string optimized string type with O(1) clone"
HOMEPAGE="https://github.com/rust-lang/rust-analyzer/tree/master/lib/smol_str"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
