# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="erased-serde"
CRATE_VERSION="0.4.10"
CRATE_CHECKSUM="d2add8a07dd6a8d93ff627029c51de145e12686fbc36ecb298ac22e74cf02dec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type-erased Serialize and Serializer traits"
HOMEPAGE="https://github.com/dtolnay/erased-serde"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"unstable-debug"
)
