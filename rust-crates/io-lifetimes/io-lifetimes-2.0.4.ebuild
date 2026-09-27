# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="io-lifetimes"
CRATE_VERSION="2.0.4"
CRATE_CHECKSUM="06432fb54d3be7964ecd3649233cddf80db2832f47fec34c01f65b3d9d774983"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A low-level I/O ownership and borrowing library"
HOMEPAGE="https://github.com/sunfishcode/io-lifetimes"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"close"
	"default"
)
