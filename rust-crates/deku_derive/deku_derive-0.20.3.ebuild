# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deku_derive"
CRATE_VERSION="0.20.3"
CRATE_CHECKSUM="bec2a42b511fc5efd9183f4f71c17885d627b17e7fd9a61a92089406caa4397e"
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
	"logging"
	"std"
)
