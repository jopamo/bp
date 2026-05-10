# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="manyhow"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="b33efb3ca6d3b07393750d4030418d594ab1139cee518f0dc88db70fec873587"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc macro error handling à la anyhow x proc-macro-error"
HOMEPAGE="https://github.com/ModProg/manyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"darling"
	"default"
	"syn"
)
