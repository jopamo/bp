# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deku"
CRATE_VERSION="0.20.3"
CRATE_CHECKSUM="ebf55291257a2a5c90cf50ae17b6bbaabc3fd13642cf3895a71c412513c19630"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="bit level serialization/deserialization proc-macro for structs"
HOMEPAGE="https://github.com/sharksforarms/deku"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"bits"
	"default"
	"descriptive-errors"
	"logging"
	"std"
)
