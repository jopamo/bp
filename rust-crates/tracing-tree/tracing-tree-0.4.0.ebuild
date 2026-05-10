# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tracing-tree"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="f459ca79f1b0d5f71c54ddfde6debfc59c8b6eeb46808ae492077f739dc7b49c"
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
