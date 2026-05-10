# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-tree"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="ac87aa03b6a4d5a7e4810d1a80c19601dbe0f8a837e9177f23af721c7ba7beec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Tracing Layer which prints a tree of spans and events."
HOMEPAGE="https://github.com/davidbarsky/tracing-tree"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"tracing-log"
)
